import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';

// ──────────────────────────────
// AUTH BOTTOM LAYOUT
// Sign in / register link row
// ──────────────────────────────

/// Bottom auth navigation row
///
/// Shows a prompt + tappable link
///
/// Usage:
/// AuthBottomLayout(
///   prompt: 'Already have an account?',
///   actionLabel: 'Sign In',
///   onAction: () => context
///     .go(RoutePaths.login),
/// )
///
/// AuthBottomLayout(
///   prompt: "Don't have an account?",
///   actionLabel: 'Register',
///   onAction: () => context
///     .go(RoutePaths.register),
/// )
class AuthBottomLayout extends StatelessWidget {
  const AuthBottomLayout({
    super.key,
    required this.prompt,
    required this.actionLabel,
    required this.onAction,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prompt,
          style: AppTextStyles.body.copyWith(
            color: Colors.white.withValues(alpha: 0.55),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 4.w),
        GestureDetector(
          onTap: onAction,
          child: Text(
            actionLabel,
            style: AppTextStyles.body.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
