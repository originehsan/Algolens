import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

class OfflineBanner extends StatefulWidget {
  const OfflineBanner({super.key});

  @override
  State<OfflineBanner> createState() => _OfflineBannerState();
}

class _OfflineBannerState extends State<OfflineBanner> {
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _listenToConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    if (mounted) {
      setState(() {
        _isOffline = result.contains(ConnectivityResult.none);
      });
    }
  }

  void _listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen(
      (result) {
        if (mounted) {
          setState(() {
            _isOffline = result.contains(ConnectivityResult.none);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOffline) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      color: const Color(0xFFEF4444).withValues(alpha: 0.90),
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
    )
        .animate()
        .slideY(
          begin: -1,
          end: 0,
          duration: 300.ms,
          curve: Curves.easeOut,
        )
        .fadeIn(duration: 300.ms)
        .shake(
          hz: 4,
          offset: const Offset(4, 0),
          duration: 400.ms,
          delay: 300.ms,
        );
  }
}
