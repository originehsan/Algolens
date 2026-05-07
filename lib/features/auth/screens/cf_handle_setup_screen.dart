import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/errors/app_exceptions.dart';
import 'package:algolens/core/network/api_endpoints.dart';
import 'package:algolens/core/network/dio_client.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/app_text_field.dart';
import 'package:algolens/core/widgets/glass_card.dart';

// ─────────────────────────────────
// CF HANDLE VERIFY STATE
// ─────────────────────────────────

enum _CfState {
  idle,
  verifying,
  verified,
  error,
}

// ─────────────────────────────────
// CF HANDLE SETUP SCREEN
// Shown once after first login
// Never shown again after setup
// ─────────────────────────────────

class CfHandleSetupScreen extends ConsumerStatefulWidget {
  const CfHandleSetupScreen({super.key});

  @override
  ConsumerState<CfHandleSetupScreen> createState() =>
      _CfHandleSetupScreenState();
}

class _CfHandleSetupScreenState
    extends ConsumerState<CfHandleSetupScreen> {
  final _handleCtrl = TextEditingController();

  _CfState _cfState = _CfState.idle;
  String? _cfError;
  String _verifiedRank = '';
  Timer? _debounce;
  bool _saving = false;

  @override
  void dispose() {
    _handleCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // ───────────────────────────────
  // DEBOUNCED VERIFICATION
  // 800ms debounce
  // GET /users/{handle}/profile
  // ───────────────────────────────

  void _onHandleChanged(String val) {
    _debounce?.cancel();
    if (val.trim().isEmpty) {
      setState(() {
        _cfState = _CfState.idle;
        _cfError = null;
        _verifiedRank = '';
      });
      return;
    }
    _debounce = Timer(
      const Duration(milliseconds: 800),
      () => _verify(val.trim()),
    );
  }

  Future<void> _verify(String handle) async {
    setState(() {
      _cfState = _CfState.verifying;
      _cfError = null;
      _verifiedRank = '';
    });

    try {
      final client = ref.read(dioClientProvider);
      final data = await client.get(
        ApiEndpoints.profile(handle),
      );

      if (!mounted) return;

      final rank = data['rank'] as String? ?? '';
      final rating = data['rating'] as int? ?? 0;

      setState(() {
        _cfState = _CfState.verified;
        _verifiedRank = rank;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$handle verified ✓  · $rank ($rating)',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 3),
        ),
      );
    } on ApiException {
      if (!mounted) return;
      setState(() {
        _cfState = _CfState.error;
        _cfError = 'Handle not found on Codeforces';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Handle not found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.danger,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // ───────────────────────────────
  // CONFIRM
  // Save handle + navigate home
  // ───────────────────────────────

  Future<void> _confirm() async {
    if (_cfState != _CfState.verified) return;

    setState(() => _saving = true);

    await SecureStorage.saveCfHandle(_handleCtrl.text.trim());

    if (!mounted) return;

    setState(() => _saving = false);

    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    final isVerified = _cfState == _CfState.verified;
    final isVerifying = _cfState == _CfState.verifying;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),

                // ─────────────────
                // Icon
                // ─────────────────
                Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.code_rounded,
                    color: AppColors.primary,
                    size: 40.r,
                  ),
                ),

                SizedBox(height: 24.h),

                // ─────────────────
                // Title
                // ─────────────────
                Text(
                  'One last thing!',
                  style: GoogleFonts.inter(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 10.h),

                Text(
                  'Enter your Codeforces handle to get started',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 32.h),

                GlassCard(
                  child: Column(
                    children: [
                      // ───────────────────────
                      // CF Handle input
                      // ───────────────────────
                      AppTextField(
                        label: 'Codeforces Handle',
                        hint: 'tourist',
                        controller: _handleCtrl,
                        prefixIcon: Icons.code_rounded,
                        textInputAction: TextInputAction.done,
                        onChanged: _onHandleChanged,
                        onSubmitted: (_) => _confirm(),
                        fieldState: isVerified
                            ? AppTextFieldState.success
                            : _cfState == _CfState.error
                                ? AppTextFieldState.error
                                : AppTextFieldState.defaultState,
                        errorText: _cfError,
                        suffixIcon: isVerifying
                            ? Icons.hourglass_empty_rounded
                            : null,
                      ),

                      // ───────────────────────
                      // Verified rank chip
                      // ───────────────────────
                      if (isVerified && _verifiedRank.isNotEmpty) ...[
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              color: AppColors.success,
                              size: 16.r,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Rank: $_verifiedRank',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ],

                      SizedBox(height: 24.h),

                      // ───────────────────────
                      // Confirm button
                      // Disabled until verified
                      // ───────────────────────
                      AppButton(
                        label: "Let's Go!",
                        onTap: isVerified ? _confirm : null,
                        isLoading: _saving,
                        isDisabled: !isVerified,
                        icon: isVerified
                            ? Icons.arrow_forward_rounded
                            : null,
                      ),

                      if (!isVerified) ...[
                        SizedBox(height: 12.h),
                        Text(
                          'Verify your handle above to continue',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                Colors.white.withValues(alpha: 0.40),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
