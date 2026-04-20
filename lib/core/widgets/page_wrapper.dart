import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';

// ──────────────────────────────
// PAGE WRAPPER
// Base wrapper for all screens
// ──────────────────────────────

/// Wraps every screen with:
/// → AppBackground (navy + orbs)
/// → SafeArea
/// → Keyboard dismiss on tap
/// → Optional scroll
/// → Optional padding
/// → Optional AppBar with title
///
/// Usage:
/// PageWrapper(
///   child: YourScreenContent(),
/// )
///
/// PageWrapper(
///   title: 'Screen Title',
///   showBackButton: true,
///   scrollable: true,
///   child: YourScreenContent(),
/// )
class PageWrapper extends StatelessWidget {
  const PageWrapper({
    super.key,
    required this.child,
    this.scrollable = false,
    this.padding,
    this.topSafe = true,
    this.bottomSafe = true,
    this.resizeToAvoidBottomInset = true,
    this.title,
    this.showBackButton = false,
    this.actions,
  });

  final Widget child;

  /// Wrap child in SingleChildScrollView
  final bool scrollable;

  /// Padding around child
  /// Defaults to horizontal 20.w
  final EdgeInsetsGeometry? padding;

  /// Include top SafeArea
  final bool topSafe;

  /// Include bottom SafeArea
  final bool bottomSafe;

  /// Resize when keyboard appears
  final bool resizeToAvoidBottomInset;

  /// Optional AppBar title
  final String? title;

  /// Show back button in AppBar
  final bool showBackButton;

  /// AppBar trailing actions
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    Widget content = child;

    // ──────────────────────────
    // PADDING
    // ──────────────────────────

    content = Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
      child: content,
    );

    // ──────────────────────────
    // SCROLL SUPPORT
    // Optional — auth screens
    // need scroll for keyboard
    // ──────────────────────────

    if (scrollable) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    // ──────────────────────────
    // SAFE AREA
    // ──────────────────────────

    content = SafeArea(
      top: topSafe,
      bottom: bottomSafe,
      child: content,
    );

    // ──────────────────────────
    // KEYBOARD DISMISS
    // Tap anywhere to dismiss
    // ──────────────────────────

    content = GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: content,
    );

    // ──────────────────────────
    // APP BACKGROUND
    // Deep navy + 2 blue orbs
    // ──────────────────────────

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: title != null
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: false,
              title: Text(
                title!,
                style: AppTextStyles.h2,
              ),
              leading: showBackButton
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : null,
              automaticallyImplyLeading: showBackButton,
              actions: actions,
            )
          : null,
      body: AppBackground(
        child: content,
      ),
    );
  }
}
