import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:algolens/core/widgets/share_profile_card.dart';
import 'package:algolens/features/profile/data/models/profile_model.dart';

/// Singleton share service — static methods only.
/// Captures ShareProfileCard as PNG and shares via system share sheet.
class ShareProfileService {
  ShareProfileService._();

  /// Renders ShareProfileCard offscreen, captures as PNG, then shares.
  static Future<void> share(
    BuildContext context,
    ProfileModel profile,
  ) async {
    try {
      final controller = ScreenshotController();

      // Render widget offscreen at 3x pixel ratio for crisp share image
      final Uint8List bytes = await controller.captureFromWidget(
        ShareProfileCard(profile: profile),
        context: context,
        delay: const Duration(milliseconds: 100),
        pixelRatio: 3.0,
      );

      // Write PNG to temp directory
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${profile.handle}_profile.png');
      await file.writeAsBytes(bytes);

      // Open system share sheet
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out my Codeforces stats on AlgoLens!\n'
            'Handle: ${profile.handle}\n'
            'Rating: ${profile.rating}\n'
            'Rank: ${profile.rank}',
        subject: 'My AlgoLens Profile - ${profile.handle}',
      );
    } catch (_) {
      // Fail silently — share is non-critical
    }
  }
}