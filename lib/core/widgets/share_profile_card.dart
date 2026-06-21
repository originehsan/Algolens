import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';

// Fixed 360x240 px — no screenutil here since this is captured as image
// Rendered offscreen by ShareProfileService, never shown directly in UI
class ShareProfileCard extends StatelessWidget {
  const ShareProfileCard({super.key, required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 360,
        height: 240,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0E1E3C),
              Color(0xFF07101F),
              Color(0xFF132A4E),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.30),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            // Decorative orb — top right corner
            Positioned(
              top: -40,
              right: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Header row — avatar, handle, rank, AlgoLens branding
                  Row(
                    children: [
                      // First letter avatar
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.20),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.50),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            profile.handle.substring(0, 1).toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.handle,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Rank badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color:
                                    AppColors.primary.withValues(alpha: 0.35),
                              ),
                            ),
                            child: Text(
                              profile.rank.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // AlgoLens branding — top right
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'AlgoLens',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'CF Analytics',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.40),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Stats row — rating, max rating, solved
                  Row(
                    children: [
                      _StatBlock(
                        label: 'Rating',
                        value: '${profile.rating}',
                        color: AppColors.primary,
                        large: true,
                      ),
                      const SizedBox(width: 24),
                      _StatBlock(
                        label: 'Max Rating',
                        value: '${profile.maxRating}',
                        color: Colors.white.withValues(alpha: 0.70),
                      ),
                      const Spacer(),
                      _StatBlock(
                        label: 'Solved',
                        value: '${profile.problemsSolved}',
                        color: AppColors.success,
                        alignEnd: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Separator
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),

                  const SizedBox(height: 16),

                  // Bottom row — contests, streak, CF URL
                  Row(
                    children: [
                      _StatBlock(
                        label: 'Contests',
                        value: '${profile.contestsParticipated}',
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 24),
                      _StatBlock(
                        label: 'Streak',
                        value: '${profile.streakDays}d',
                        color: AppColors.danger,
                      ),
                      const Spacer(),
                      // CF profile link — subtle watermark
                      Text(
                        'codeforces.com/profile/${profile.handle}',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({
    required this.label,
    required this.value,
    required this.color,
    this.large = false,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final Color color;
  final bool large;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            fontSize: large ? 28 : 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.50),
          ),
        ),
      ],
    );
  }
}