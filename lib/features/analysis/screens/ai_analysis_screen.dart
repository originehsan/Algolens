import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/core/widgets/app_background.dart';
import 'package:algolens/core/widgets/app_button.dart';
import 'package:algolens/core/widgets/glass_card.dart';
import 'package:algolens/core/widgets/section_header.dart';
import 'package:algolens/features/analysis/data/models/analysis_model.dart';
import 'package:algolens/features/analysis/providers/analysis_provider.dart';

class AiAnalysisScreen extends ConsumerWidget {
  const AiAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiAnalysisProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: true,
              title: Text('AI Analysis', style: AppTextStyles.h2),
              actions: [
                // Show reset button only when results are visible
                if (state is AnalysisSuccess)
                  IconButton(
                    onPressed: () =>
                        ref.read(aiAnalysisProvider.notifier).reset(),
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: AppColors.primary,
                      size: 22.r,
                    ),
                  ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 8.h),

                  // Render based on current analysis state
                  if (state is AnalysisIdle)
                    _IdleView(
                      onRun: () =>
                          ref.read(aiAnalysisProvider.notifier).runAnalysis(),
                    ),

                  if (state is AnalysisLoading) const _LoadingView(),

                  if (state is AnalysisError)
                    _ErrorView(
                      message: state.message,
                      onRetry: () =>
                          ref.read(aiAnalysisProvider.notifier).runAnalysis(),
                    ),

                  if (state is AnalysisSuccess)
                    _ResultsView(response: state.response),

                  SizedBox(height: 100.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────
// IDLE VIEW
// ─────────────────────────────────

class _IdleView extends StatelessWidget {
  const _IdleView({required this.onRun});
  final VoidCallback onRun;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),

        Container(
          width: 100.r,
          height: 100.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.10),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.30),
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.primary,
            size: 48.r,
          ),
        ),

        SizedBox(height: 24.h),

        Text(
          'AI Upsolve Analysis',
          style: AppTextStyles.h1,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 12.h),

        Text(
          'Get personalized insights on problems you\'ve '
          'attempted but haven\'t solved yet.\n\nPowered by Groq AI.',
          style: AppTextStyles.body.copyWith(
            color: Colors.white.withValues(alpha: 0.60),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 16.h),

        // Warn user about wait time before they tap
        GlassCard(
          child: Row(
            children: [
              Icon(Icons.timer_outlined, color: AppColors.warning, size: 18.r),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Analysis takes 5-30 seconds. Please keep the app open.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.70),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        AppButton(
          label: 'Run AI Analysis',
          onTap: onRun,
          icon: Icons.auto_awesome_rounded,
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// LOADING VIEW
// Animated rotating messages
// so user knows Groq is working
// ─────────────────────────────────

class _LoadingView extends ConsumerStatefulWidget {
  const _LoadingView();

  @override
  ConsumerState<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends ConsumerState<_LoadingView> {
  int _msgIndex = 0;
  Timer? _timer;

  // Rotate through these messages every 4 seconds
  final _messages = const [
    'Fetching your submissions...',
    'Analysing problem patterns...',
    'Identifying weak areas...',
    'Generating insights with AI...',
    'Almost done...',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      setState(() => _msgIndex = (_msgIndex + 1) % _messages.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.h),

        // Pulsing AI icon
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.8, end: 1.0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          builder: (_, v, child) => Transform.scale(scale: v, child: child),
          child: Container(
            width: 80.r,
            height: 80.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.15),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.50),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.primary,
              size: 40.r,
            ),
          ),
        ),

        SizedBox(height: 24.h),

        Text('Analysing...', style: AppTextStyles.h2),

        SizedBox(height: 12.h),

        // Animated message switcher
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: Text(
            _messages[_msgIndex],
            key: ValueKey(_msgIndex),
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.60),
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 32.h),

        SizedBox(
          width: 40.r,
          height: 40.r,
          child:  const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),

        SizedBox(height: 16.h),

        Text(
          'This may take up to 30 seconds',
          style: AppTextStyles.caption.copyWith(
            color: Colors.white.withValues(alpha: 0.40),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// ERROR VIEW
// ─────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),

        Icon(
          Icons.error_outline_rounded,
          color: AppColors.danger.withValues(alpha: 0.70),
          size: 48.r,
        ),

        SizedBox(height: 16.h),

        Text('Analysis Failed', style: AppTextStyles.h2),

        SizedBox(height: 8.h),

        GlassCard(
          child: Text(
            message,
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.70),
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 24.h),

        AppButton(
          label: 'Try Again',
          onTap: onRetry,
          type: AppButtonType.outline,
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// RESULTS VIEW
// ─────────────────────────────────

class _ResultsView extends StatelessWidget {
  const _ResultsView({required this.response});
  final AnalysisResponse response;

  @override
  Widget build(BuildContext context) {
    // Handle empty Groq response
    if (response.isEmpty) {
      return Column(
        children: [
          SizedBox(height: 40.h),
          Icon(Icons.check_circle_rounded, color: AppColors.success, size: 48.r),
          SizedBox(height: 16.h),
          Text('Nothing to analyse!', style: AppTextStyles.h2),
          SizedBox(height: 8.h),
          Text(
            'You have no unsolved problems to analyse. Keep solving!',
            style: AppTextStyles.body.copyWith(
              color: Colors.white.withValues(alpha: 0.60),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Overall recommendation section
        if (response.overallRecommendation.isNotEmpty) ...[
          const SectionHeader(title: 'Overall Recommendation'),
          SizedBox(height: 12.h),
          GlassCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_rounded, color: AppColors.primary, size: 20.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    response.overallRecommendation,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],

        SectionHeader(
          title: 'Problem Breakdown',
          subtitle: '${response.totalAnalysed} problems analysed',
        ),
        SizedBox(height: 12.h),

        // Per-problem analysis cards
        ...response.problemAnalyses.map(
          (a) => _AnalysisCard(analysis: a),
        ),
      ],
    );
  }
}

// ─────────────────────────────────
// ANALYSIS CARD
// ─────────────────────────────────

class _AnalysisCard extends StatelessWidget {
  const _AnalysisCard({required this.analysis});
  final ProblemAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Problem label badge e.g. "1991D"
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.30),
                  ),
                ),
                child: Text(
                  analysis.shortLabel,
                  style: AppTextStyles.monoSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              // Problem name tappable — opens CF in browser
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse(analysis.url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  child: Text(
                    analysis.problemName,
                    style: AppTextStyles.bodyBold.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withValues(alpha: 0.30),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _AnalysisRow(
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.warning,
            label: 'Likely Issue',
            value: analysis.likelyIssue,
          ),
          SizedBox(height: 10.h),
          _AnalysisRow(
            icon: Icons.school_rounded,
            iconColor: AppColors.primary,
            label: 'Study',
            value: analysis.conceptToStudy,
          ),
          SizedBox(height: 10.h),
          _AnalysisRow(
            icon: Icons.tips_and_updates_rounded,
            iconColor: AppColors.success,
            label: 'Action',
            value: analysis.actionableTip,
          ),
        ],
      ),
    );
  }
}

class _AnalysisRow extends StatelessWidget {
  const _AnalysisRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 16.r),
        SizedBox(width: 8.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    color: iconColor,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.75),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}