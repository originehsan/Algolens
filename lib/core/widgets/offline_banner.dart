import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/providers/ui_providers.dart';

// ──────────────────────────────
// OFFLINE BANNER
// No internet indicator
// ──────────────────────────────

/// Offline banner widget
///
/// Shows when device loses internet
/// Watches connectivityStreamProvider
/// Animated slide + fade
///
/// Usage:
/// Place at top of screen stack
/// or integrated in main layout
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final connectivity = ref.watch(
      connectivityStreamProvider,
    );

    return connectivity.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (results) {
        final isOffline = results.every(
          (r) => r == ConnectivityResult.none,
        );

        return AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),
          child: isOffline
              ? const _BannerContent(
                  key: ValueKey(
                    'offline',
                  ),
                )
              : const SizedBox.shrink(
                  key: ValueKey(
                    'online',
                  ),
                ),
        );
      },
    );
  }
}

// ──────────────────────────────
// BANNER CONTENT
// ──────────────────────────────

class _BannerContent extends StatelessWidget {
  const _BannerContent({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: const AlwaysStoppedAnimation(
        Offset(0, -1),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(
            alpha: 0.90,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              color: Colors.white,
              size: 16.r,
            ),
            SizedBox(width: 8.w),
            Text(
              'No internet connection',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
