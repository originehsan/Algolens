import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// A stacked, JioHotstar-style card carousel.
///
/// Design notes:
/// - Cards are always opaque. "Depth" is expressed by a darkening scrim
///   (`dim`), never by transparency, so adjacent peeking cards never bleed
///   through into each other.
/// - Horizontal motion of the active card is a raw 1:1 translation of the
///   finger. The "sink" on a back-swipe lives only on the Y-axis + dim.
/// - All animation is driven through a single [AnimationController] read by
///   one [AnimatedBuilder]. There is no per-frame `setState`; the only
///   rebuilds that touch the page index happen once, on commit.
class StackedCardCarousel extends StatefulWidget {
  const StackedCardCarousel({
    super.key,
    required this.items,
    this.cardHeight = 340.0,
    this.horizontalPadding = 14.0,
    this.behindScale1 = 0.95,
    this.behindScale2 = 0.90,
    this.behindOpacity1 = 0.80,
    this.behindOpacity2 = 0.50,
    this.behindPeekY1 = 10.0,
    this.behindPeekY2 = 18.0,
    this.borderRadius = 18.0,
    this.swipeThresholdFraction = 0.35,
    this.velocityThreshold = 450.0,
    this.peekWidth = 24.0,
    this.onPageChanged,
    this.autoPlayDuration = const Duration(seconds: 5),
    this.loop = true,
    this.autoPlay = true,
    this.behindLayers = 2,
    this.showDots = true,
    this.settleInOnPageChange = true,
    this.surfaceColor = const Color(0xFF0D1B2E),
    this.borderColor = const Color(0x29FFFFFF),
    this.dotActiveColor = const Color(0xFF4DA3FF),
    this.dotInactiveColor = const Color(0x5AFFFFFF),
  });

  final List<Widget> items;
  final double cardHeight;
  final double horizontalPadding;
  final double behindScale1;
  final double behindScale2;
  final double behindOpacity1;
  final double behindOpacity2;
  final double behindPeekY1;
  final double behindPeekY2;
  final double borderRadius;
  final double swipeThresholdFraction;
  final double velocityThreshold;
  final double peekWidth;
  final ValueChanged<int>? onPageChanged;
  final Duration autoPlayDuration;

  /// Wrap around past the last/first card.
  final bool loop;

  /// Auto-advance forward on a timer.
  final bool autoPlay;

  /// Number of peeking cards rendered behind the active one (1–3 is sane).
  final int behindLayers;

  /// Render the page-indicator dots row below the cards.
  final bool showDots;

  /// Subtle scale "snap into focus" each time the active card changes.
  final bool settleInOnPageChange;

  /// Opaque backing color shown if a card's child doesn't fully paint.
  final Color surfaceColor;

  /// Hairline rim highlight on every card.
  final Color borderColor;

  final Color dotActiveColor;
  final Color dotInactiveColor;

  @override
  State<StackedCardCarousel> createState() => _StackedCardCarouselState();
}

class _StackedCardCarouselState extends State<StackedCardCarousel>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  // `_ctl.value` IS the drag offset in px. Single source of truth for the
  // active card's X position; every other transform is derived from it.
  late final AnimationController _ctl;
  Timer? _autoTimer;

  int _current = 0;
  bool _isDragging = false;
  bool _committingLeft = false;
  bool _committingRight = false;
  bool _appResumed = true;
  bool _reduceMotion = false;

  // Measured from LayoutBuilder each layout pass (not screen width).
  double _cardWidth = 0;

  static const double _prevGap = 6.0;
  static const double _boundaryResistance = 0.08;

  int get _count => widget.items.length;
  double get _pos => _ctl.value;
  double get _boundaryOverdragLimit => widget.peekWidth * 2.5;

  bool get _canGoNext =>
      _count > 1 && (widget.loop || _current < _count - 1);
  bool get _canGoPrev => _count > 1 && (widget.loop || _current > 0);

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController.unbounded(vsync: this)
      ..addListener(_onCommitTick);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    _restartAutoPlay();
  }

  @override
  void didUpdateWidget(covariant StackedCardCarousel old) {
    super.didUpdateWidget(old);
    if (_current > _count - 1) {
      _current = _count == 0 ? 0 : _count - 1;
      _ctl.value = 0;
    }
    _restartAutoPlay();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final resumed = state == AppLifecycleState.resumed;
    if (resumed == _appResumed) return;
    _appResumed = resumed;
    resumed ? _restartAutoPlay() : _autoTimer?.cancel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _autoTimer?.cancel();
    _ctl.dispose();
    super.dispose();
  }

  // ── Geometry ────────────────────────────────────────────────────────────

  // Active card slides fully clear on a forward commit.
  double _exitLeftX() => -(_cardWidth + _prevGap);

  // Lands the incoming prev card exactly centered on a back commit.
  double _exitRightX() => _cardWidth + _prevGap;

  double get _leftProgress {
    if (_cardWidth <= 0 || _pos >= 0) return 0;
    return (-_pos / (_cardWidth * 0.62)).clamp(0.0, 1.0);
  }

  double get _rightProgress {
    if (_cardWidth <= 0 || _pos <= 0) return 0;
    return (_pos / (_cardWidth * 0.62)).clamp(0.0, 1.0);
  }

  // ── Auto-play ───────────────────────────────────────────────────────────

  void _restartAutoPlay() {
    _autoTimer?.cancel();
    if (!widget.autoPlay || _reduceMotion || !_appResumed) return;
    if (_count <= 1 || !_canGoNext) return;
    _autoTimer = Timer.periodic(widget.autoPlayDuration, (_) {
      if (_isDragging || _committingLeft || _committingRight) return;
      if (!_canGoNext) {
        _autoTimer?.cancel();
        return;
      }
      _commitLeft(releaseVelocity: 0, isAuto: true);
    });
  }

  // ── Commit / finalize ───────────────────────────────────────────────────

  void _onCommitTick() {
    if (_committingLeft && _ctl.value <= _exitLeftX()) {
      _ctl.stop();
      _finalizeLeft();
    } else if (_committingRight && _ctl.value >= _exitRightX()) {
      _ctl.stop();
      _finalizeRight();
    }
  }

  void _commitLeft({required double releaseVelocity, bool isAuto = false}) {
    if (_committingLeft || _committingRight) return;
    if (!_canGoNext) {
      _snapBack(releaseVelocity: releaseVelocity);
      return;
    }
    _committingLeft = true;
    final target = _exitLeftX();
    _ctl.value = _pos;
    if (_reduceMotion) {
      _ctl.value = target; // notifies -> _onCommitTick finalizes
      return;
    }
    if (isAuto) {
      _ctl.animateTo(
        target,
        duration: const Duration(milliseconds: 620),
        curve: Curves.easeInOutCubic,
      );
    } else {
      final speed = releaseVelocity.abs().clamp(400.0, 1800.0);
      const spring = SpringDescription(mass: 1, stiffness: 165, damping: 22);
      _ctl.animateWith(SpringSimulation(spring, _pos, target, -speed));
    }
  }

  void _commitRight({required double releaseVelocity}) {
    if (_committingLeft || _committingRight) return;
    if (!_canGoPrev) {
      _snapBack(releaseVelocity: releaseVelocity);
      return;
    }
    _committingRight = true;
    final target = _exitRightX();
    _ctl.value = _pos;
    if (_reduceMotion) {
      _ctl.value = target;
      return;
    }
    final speed = releaseVelocity.abs().clamp(400.0, 1800.0);
    const spring = SpringDescription(mass: 1, stiffness: 165, damping: 22);
    _ctl.animateWith(SpringSimulation(spring, _pos, target, speed));
  }

  void _finalizeLeft() {
    _committingLeft = false;
    setState(() {
      _current = (_current + 1) % _count;
      _ctl.value = 0;
    });
    widget.onPageChanged?.call(_current);
    _restartAutoPlay();
  }

  void _finalizeRight() {
    _committingRight = false;
    setState(() {
      _current = (_current - 1 + _count) % _count;
      _ctl.value = 0;
    });
    widget.onPageChanged?.call(_current);
    _restartAutoPlay();
  }

  void _snapBack({required double releaseVelocity}) {
    _committingLeft = false;
    _committingRight = false;
    if (_reduceMotion) {
      _ctl.value = 0;
      return;
    }
    const spring = SpringDescription(mass: 1, stiffness: 380, damping: 34);
    _ctl.animateWith(SpringSimulation(spring, _pos, 0.0, releaseVelocity));
  }

  // ── Gestures (horizontal only, so vertical scroll passes through) ────────

  void _onDragStart(DragStartDetails d) {
    if (_committingLeft || _committingRight) return;
    _isDragging = true;
    _ctl.stop();
    _autoTimer?.cancel();
  }

  void _onDragUpdate(DragUpdateDetails d) {
    if (!_isDragging) return;
    double delta = d.delta.dx;

    // Rubber-band when there's no real card to reveal in that direction.
    if (delta < 0 && !_canGoNext) delta *= _boundaryResistance;
    if (delta > 0 && !_canGoPrev) delta *= _boundaryResistance;

    double pos = _pos + delta;

    if (!_canGoNext && pos < -_boundaryOverdragLimit) {
      pos = -_boundaryOverdragLimit;
    }
    if (!_canGoPrev && pos > _boundaryOverdragLimit) {
      pos = _boundaryOverdragLimit;
    }
    if (_canGoNext && pos < _exitLeftX()) pos = _exitLeftX();
    if (_canGoPrev && pos > _exitRightX()) pos = _exitRightX();

    _ctl.value = pos; // drives AnimatedBuilder; no setState
  }

  void _onDragEnd(DragEndDetails d) {
    if (!_isDragging) return;
    _isDragging = false;
    final vx = d.velocity.pixelsPerSecond.dx;
    final threshold = _cardWidth * widget.swipeThresholdFraction;

    if ((_pos < -threshold || vx < -widget.velocityThreshold) && _canGoNext) {
      _commitLeft(releaseVelocity: vx);
    } else if ((_pos > threshold || vx > widget.velocityThreshold) &&
        _canGoPrev) {
      _commitRight(releaseVelocity: vx);
    } else {
      _snapBack(releaseVelocity: vx);
    }
    _restartAutoPlay();
  }

  // ── Index resolution (loop-aware, collision-guarded) ─────────────────────

  int _visibleBehindCount() {
    final cap = widget.loop ? _count - 1 : _count - 1 - _current;
    return cap.clamp(0, widget.behindLayers);
  }

  int? _neighborIndex(int depth) {
    if (widget.loop) {
      if (_count <= depth) return null;
      final idx = (_current + depth) % _count;
      if (_prevIndex() == idx) return null; // avoid double-rendering one card
      return idx;
    }
    final idx = _current + depth;
    return idx < _count ? idx : null;
  }

  int? _prevIndex() {
    if (widget.loop) {
      if (_count <= 2) return null;
      return (_current - 1 + _count) % _count;
    }
    return _current > 0 ? _current - 1 : null;
  }

  // ── Per-depth rest poses. Depth 0 == the active card. ────────────────────
  // A behind card promotes from its own rest pose toward the rest pose of the
  // depth ABOVE it, so when the index shifts on commit nothing teleports.

  double _restScale(int d) {
    if (d <= 0) return 1.0;
    if (d == 1) return widget.behindScale1;
    if (d == 2) return widget.behindScale2;
    final step = widget.behindScale1 - widget.behindScale2;
    return widget.behindScale2 - step * (d - 2);
  }

  double _restDim(int d) {
    if (d <= 0) return 0.0;
    final double o;
    if (d == 1) {
      o = widget.behindOpacity1;
    } else if (d == 2) {
      o = widget.behindOpacity2;
    } else {
      final step = widget.behindOpacity1 - widget.behindOpacity2;
      o = (widget.behindOpacity2 - step * (d - 2)).clamp(0.0, 1.0);
    }
    return (1.0 - o).clamp(0.0, 0.85);
  }

  double _restPeekY(int d) {
    if (d <= 0) return 0.0;
    if (d == 1) return widget.behindPeekY1;
    if (d == 2) return widget.behindPeekY2;
    final step = widget.behindPeekY2 - widget.behindPeekY1;
    return widget.behindPeekY2 + step * (d - 2);
  }

  double _restPeekTx(int d) {
    if (d <= 0) return 0.0;
    return d == 1 ? widget.peekWidth : 0.0;
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (_count == 0) return SizedBox(height: widget.cardHeight);

    return Semantics(
      container: true,
      label: 'Carousel, ${_current + 1} of $_count',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: widget.cardHeight,
            child: LayoutBuilder(
              builder: (context, constraints) {
                _cardWidth =
                    constraints.maxWidth - widget.horizontalPadding * 2;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalPadding,
                  ),
                  child: ClipRect(
                    child: AnimatedBuilder(
                      animation: _ctl,
                      builder: (context, _) => _buildStack(),
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.showDots && _count > 1) _buildDots(),
        ],
      ),
    );
  }

  Widget _buildStack() {
    if (_cardWidth <= 0) {
      return _ActiveTopCard(
        borderRadius: widget.borderRadius,
        surfaceColor: widget.surfaceColor,
        borderColor: widget.borderColor,
        dragX: 0,
        sinkY: 0,
        dim: 0,
        settleKey: _current,
        settleIn: false,
        onDragStart: null,
        onDragUpdate: null,
        onDragEnd: null,
        child: widget.items[_current],
      );
    }

    final lp = _leftProgress;
    final rp = _rightProgress;
    final children = <Widget>[];

    // Behind cards, deepest first.
    final layers = _visibleBehindCount();
    for (int d = layers; d >= 1; d--) {
      final idx = _neighborIndex(d);
      if (idx == null) continue;
      final p = lp.clamp(0.0, 1.0);
      children.add(
        _BehindCard(
          borderRadius: widget.borderRadius,
          surfaceColor: widget.surfaceColor,
          borderColor: widget.borderColor,
          scale: lerpDouble(_restScale(d), _restScale(d - 1), p)!,
          dim: lerpDouble(_restDim(d), _restDim(d - 1), p)!,
          peekY: lerpDouble(_restPeekY(d), _restPeekY(d - 1), p)!,
          peekTx: lerpDouble(_restPeekTx(d), _restPeekTx(d - 1), p)!,
          child: widget.items[idx],
        ),
      );
    }

    // Active card.
    final canDrag = _count > 1;
    children.add(
      _ActiveTopCard(
        borderRadius: widget.borderRadius,
        surfaceColor: widget.surfaceColor,
        borderColor: widget.borderColor,
        dragX: _pos,
        sinkY: lerpDouble(0.0, 16.0, rp)!,
        dim: lerpDouble(0.0, 0.18, rp)!,
        settleKey: _current,
        settleIn: widget.settleInOnPageChange && !_reduceMotion,
        onDragStart: canDrag ? _onDragStart : null,
        onDragUpdate: canDrag ? _onDragUpdate : null,
        onDragEnd: canDrag ? _onDragEnd : null,
        child: widget.items[_current],
      ),
    );

    // Prev card slides in from the left on a back-swipe.
    final prevIdx = _prevIndex();
    if (prevIdx != null) {
      final restDx = -(_cardWidth + _prevGap);
      children.add(
        _IncomingCard(
          borderRadius: widget.borderRadius,
          surfaceColor: widget.surfaceColor,
          borderColor: widget.borderColor,
          dx: _pos > 0 ? restDx + _pos : restDx,
          dim: lerpDouble(0.45, 0.0, rp)!.clamp(0.0, 0.6),
          child: widget.items[prevIdx],
        ),
      );
    }

    return Stack(clipBehavior: Clip.none, children: children);
  }

  Widget _buildDots() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_count, (i) {
          final active = i == _current;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: active ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: active ? widget.dotActiveColor : widget.dotInactiveColor,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// _ActiveTopCard
// ═══════════════════════════════════════════════════════════════════════════

class _ActiveTopCard extends StatelessWidget {
  const _ActiveTopCard({
    required this.child,
    required this.borderRadius,
    required this.surfaceColor,
    required this.borderColor,
    required this.dragX,
    required this.sinkY,
    required this.dim,
    required this.settleKey,
    required this.settleIn,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  final Widget child;
  final double borderRadius;
  final Color surfaceColor;
  final Color borderColor;
  final double dragX;
  final double sinkY;
  final double dim;
  final int settleKey;
  final bool settleIn;
  final GestureDragStartCallback? onDragStart;
  final GestureDragUpdateCallback? onDragUpdate;
  final GestureDragEndCallback? onDragEnd;

  @override
  Widget build(BuildContext context) {
    Widget shell = RepaintBoundary(
      child: _CardShell(
        borderRadius: borderRadius,
        surfaceColor: surfaceColor,
        borderColor: borderColor,
        dim: dim,
        child: child,
      ),
    );

    // "Snap into focus" — fires only when the page index changes (key change),
    // so it never re-runs during a drag. Kept tiny to avoid a visible dip.
    if (settleIn) {
      shell = TweenAnimationBuilder<double>(
        key: ValueKey<int>(settleKey),
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: shell,
        builder: (context, t, inner) {
          return Transform.scale(scale: lerpDouble(0.99, 1.0, t)!, child: inner);
        },
      );
    }

    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        child: Transform.translate(
          offset: Offset(dragX, sinkY),
          child: shell,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// _BehindCard
// ═══════════════════════════════════════════════════════════════════════════

class _BehindCard extends StatelessWidget {
  const _BehindCard({
    required this.child,
    required this.borderRadius,
    required this.surfaceColor,
    required this.borderColor,
    required this.scale,
    required this.dim,
    required this.peekY,
    required this.peekTx,
  });

  final Widget child;
  final double borderRadius;
  final Color surfaceColor;
  final Color borderColor;
  final double scale;
  final double dim;
  final double peekY;
  final double peekTx;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..translateByDouble(peekTx, peekY, 0.0, 1.0)
          ..scaleByDouble(scale, scale, 1.0, 1.0),
        child: RepaintBoundary(
          child: _CardShell(
            borderRadius: borderRadius,
            surfaceColor: surfaceColor,
            borderColor: borderColor,
            dim: dim,
            child: child,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// _IncomingCard
// ═══════════════════════════════════════════════════════════════════════════

class _IncomingCard extends StatelessWidget {
  const _IncomingCard({
    required this.borderRadius,
    required this.surfaceColor,
    required this.borderColor,
    required this.dx,
    required this.dim,
    required this.child,
  });

  final double borderRadius;
  final Color surfaceColor;
  final Color borderColor;
  final double dx;
  final double dim;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Transform.translate(
          offset: Offset(dx, 0),
          child: RepaintBoundary(
            child: _CardShell(
              borderRadius: borderRadius,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              dim: dim,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// _CardShell — opaque card with depth scrim + hairline rim + shadow
// ═══════════════════════════════════════════════════════════════════════════

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.borderRadius,
    required this.surfaceColor,
    required this.borderColor,
    required this.child,
    this.dim = 0.0,
  });

  final double borderRadius;
  final Color surfaceColor;
  final Color borderColor;
  final Widget child;

  /// 0.0 = full brightness. Higher darkens to read as further back, without
  /// ever becoming see-through.
  final double dim;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: surfaceColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 28,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x52000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Positioned.fill(child: child),
            if (dim > 0.0)
              Positioned.fill(
                child: IgnorePointer(
                  child: ColoredBox(color: Color.fromRGBO(0, 0, 0, dim)),
                ),
              ),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: borderColor, width: 1.2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}