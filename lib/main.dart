import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ────────────────────────────
  // LOAD ENV
  // Must be first
  // ────────────────────────────
  await dotenv.load(
    fileName: '.env',
  );

  // ────────────────────────────
  // INIT HIVE
  // Opens all 6 boxes
  // Must be before runApp
  // ────────────────────────────
  await HiveService.init();

  // ────────────────────────────
  // SYSTEM UI
  // ────────────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF060B14),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: AlgoLensApp(),
    ),
  );
}

// ──────────────────────────────
// ROOT APP WIDGET
// ──────────────────────────────

class AlgoLensApp extends ConsumerWidget {
  const AlgoLensApp({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final router = ref.watch(
      routerProvider,
    );

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'AlgoLens',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: router,
        );
      },
    );
  }
}
