import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Top-left back button for auth screens.
/// Uses CupertinoIcons.back for native feel.
/// Used by: forgot_password, otp,
/// reset_password screens.
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onBack,
        child: Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.06,
            ),
            borderRadius:
                BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.10,
              ),
              width: 1,
            ),
          ),
          child: Icon(
            CupertinoIcons.back,
            color: Colors.white.withValues(
              alpha: 0.70,
            ),
            size: 18.r,
          ),
        ),
      ),
    );
  }
}