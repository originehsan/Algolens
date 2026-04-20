import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// USER AVATAR
// CF profile picture widget
// ──────────────────────────────

/// Circular avatar with rank border
///
/// Features:
/// → cached_network_image
/// → Fallback initials if no URL
/// → Rank color border ring
/// → Configurable size
/// → Optional tap handler
///
/// Usage:
/// UserAvatar(
///   avatarUrl: profile.avatar,
///   handle: profile.handle,
///   rank: profile.rank,
///   size: 44.r,
/// )
///
/// UserAvatar(
///   avatarUrl: null,
///   handle: 'tourist',
///   rank: 'legendary grandmaster',
///   size: 80.r,
///   onTap: () => context
///     .push(RoutePaths.profile),
/// )
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.handle,
    required this.rank,
    this.avatarUrl,
    this.size,
    this.onTap,
    this.showBorder = true,
  });

  final String handle;
  final String rank;
  final String? avatarUrl;
  final double? size;
  final VoidCallback? onTap;
  final bool showBorder;

  // ────────────────────────────
  // FALLBACK INITIALS
  // First letter of handle
  // ────────────────────────────

  String get _initials {
    if (handle.isEmpty) return '?';
    return handle[0].toUpperCase();
  }

  // ────────────────────────────
  // BORDER COLOR
  // From rank
  // ────────────────────────────

  Color get _borderColor => AppColors.rankColor(rank);

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? 44.r;
    final borderWidth = showBorder ? 2.0 : 0.0;

    Widget avatar;

    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      // ──────────────────────
      // NETWORK IMAGE
      // cached_network_image
      // ──────────────────────

      avatar = CachedNetworkImage(
        imageUrl: avatarUrl!,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: avatarSize / 2,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => _InitialsAvatar(
          initials: _initials,
          size: avatarSize,
          rank: rank,
        ),
        errorWidget: (context, url, error) => _InitialsAvatar(
          initials: _initials,
          size: avatarSize,
          rank: rank,
        ),
      );
    } else {
      // ──────────────────────
      // FALLBACK INITIALS
      // ──────────────────────

      avatar = _InitialsAvatar(
        initials: _initials,
        size: avatarSize,
        rank: rank,
      );
    }

    // ──────────────────────────
    // RANK BORDER RING
    // ──────────────────────────

    Widget bordered = Container(
      width: avatarSize + (borderWidth * 2) + 4,
      height: avatarSize + (borderWidth * 2) + 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: _borderColor,
                width: borderWidth,
              )
            : null,
        boxShadow: showBorder
            ? [
                BoxShadow(
                  color: _borderColor.withValues(
                    alpha: 0.40,
                  ),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Center(child: avatar),
    );

    // ──────────────────────────
    // TAP HANDLER
    // ──────────────────────────

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: bordered,
      );
    }

    return bordered;
  }
}

// ──────────────────────────────
// INITIALS AVATAR
// Fallback when no image
// ──────────────────────────────

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar({
    required this.initials,
    required this.size,
    required this.rank,
  });

  final String initials;
  final double size;
  final String rank;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.rankColor(rank).withValues(alpha: 0.20),
      child: Text(
        initials,
        style: AppTextStyles.body.copyWith(
          color: AppColors.rankColor(rank),
          fontWeight: FontWeight.w700,
          fontSize: size * 0.35,
        ),
      ),
    );
  }
}
