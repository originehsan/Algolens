import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:algolens/core/local/hive_service.dart';
import 'package:algolens/core/local/notification_service.dart';
import 'package:algolens/core/local/tts_service.dart';
import 'package:algolens/core/local/widget_service.dart';
import 'package:algolens/core/local/workmanager_service.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load .env — must be before any EnvConfig access
  await dotenv.load(fileName: '.env');

  // 2. Init Hive first — all other services may read from boxes
  await HiveService.init();

  // 3. Init notification channels and handlers
  await NotificationService.init();

  // 4. Init TTS engine with default settings
  await TtsService.init();

  // 5. Init home widget app group (iOS) and defaults
  await WidgetService.init();

  // 6. Register background callback dispatcher
  await WorkmanagerService.init();

  // 7. Register periodic background tasks (widget + notif reschedule)
  await WorkmanagerService.registerTasks();

  // 8. Lock to portrait — prevents layout issues on tablets
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 9. Style system UI bars
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFF060B14),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // 10. Launch app
  runApp(
    const ProviderScope(
      child: AlgoLensApp(),
    ),
  );
}

/// Root widget — watches routerProvider so GoRouter is always up to date.
class AlgoLensApp extends ConsumerWidget {
  const AlgoLensApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) => MaterialApp.router(
        title: 'AlgoLens',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: router,
        // Lock text scale to 1.0 — prevents system font size breaking UI layout
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}