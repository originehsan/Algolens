# AlgoLens — Project Context File
# Read this before writing any code
# Never create duplicate classes or widgets
# Always import from exact paths listed here

---

## PROJECT OVERVIEW

**App Name:** AlgoLens  
**Package Name:** algolens  
**Description:** Competitive Programming Analytics Platform  
**Version:** 1.0.0+1  
**Purpose:** Provides comprehensive analytics, contest tracking, problem practice, and performance insights for competitive programmers across multiple platforms

---

## TECHNOLOGY STACK

### Core Framework
- **Flutter Version:** Latest Stable (3.0.0+)
- **Dart SDK:** >=3.0.0 <4.0.0
- **Platform Support:** Android, iOS, Web, macOS, Linux, Windows

### Architecture
- **State Management:** flutter_riverpod (v2.5.1)
- **Navigation:** go_router (v13.2.0)
- **HTTP Client:** dio (v5.4.0) + pretty_dio_logger (v1.3.1)
- **Local Database:** isar (v3.1.0) + isar_flutter_libs (v3.1.0)
- **Secure Storage:** flutter_secure_storage (v9.0.0)
- **Preferences:** shared_preferences (v2.2.3)

### UI Framework
- **Design System:** flutter_screenutil (v5.9.0) for responsive sizing
- **Fonts:** google_fonts (v6.2.1)
- **Icons/SVG:** flutter_svg (v2.0.10)
- **State Display:** shimmer (v3.0.0) for loading states
- **Charts:** fl_chart (v0.67.0)
- **Cards:** flutter_card_swiper (v7.0.1)
- **Animations:** flutter_animate (v4.5.0) + lottie (v3.1.0)
- **Other UI:** gap (v3.0.1), percent_indicator (v4.2.3), animated_text_kit (v4.2.2)
- **Navigation Bar:** salomon_bottom_bar (v3.3.2)

### Features & Integrations
- **Notifications:** flutter_local_notifications (v17.0.0) + timezone (v0.9.2)
- **Text-to-Speech:** flutter_tts (v4.0.2)
- **URL Handling:** url_launcher (v6.2.6)
- **Share:** share_plus (v7.2.2)
- **Screenshots:** screenshot (v2.1.0)
- **Network Status:** connectivity_plus (v6.0.3)
- **Localization:** intl (v0.19.0)
- **Home Widget:** home_widget (v0.4.1)
- **Background Tasks:** workmanager (v0.9.0)
- **App Info:** package_info_plus (v5.0.1)
- **JSON Serialization:** json_annotation (v4.8.1) + json_serializable (v6.7.1)
- **Environment:** flutter_dotenv (v5.1.0)

### Development Tools
- **Build Runner:** build_runner (v2.4.0)
- **Code Generator:** isar_generator (v3.1.0)
- **Linting:** flutter_lints (v3.0.0)

---

## PROJECT STRUCTURE

```
algolens/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── core/                     # Shared utilities and infrastructure
│   │   ├── config/               # App configuration
│   │   ├── errors/               # Error handling & exceptions
│   │   ├── network/              # HTTP client & interceptors
│   │   ├── providers/            # Global providers
│   │   ├── router/               # Navigation configuration
│   │   ├── storage/              # Database & cache logic
│   │   ├── theme/                # Design system & styling
│   │   │   ├── app_colors.dart         # Color palette
│   │   │   ├── app_text_styles.dart    # Text styles
│   │   │   └── app_decorations.dart    # Common decorations
│   │   └── widgets/              # Reusable UI components
│   │       ├── app_background.dart
│   │       ├── page_wrapper.dart       # Root widget for all screens
│   │       ├── app_button.dart         # Primary button widget
│   │       ├── app_text_field.dart     # Custom text input
│   │       ├── glass_card.dart         # Card component
│   │       ├── main_scaffold.dart      # Main app layout
│   │       ├── auth_bottom_layout.dart # Auth screens layout
│   │       ├── rank_chip.dart          # Codeforces rank display
│   │       ├── contest_card.dart       # Contest display card
│   │       ├── problem_row.dart        # Problem list item
│   │       ├── stat_card.dart          # Statistics display
│   │       ├── user_avatar.dart        # User profile picture
│   │       ├── countdown_timer.dart    # Timer component
│   │       ├── loading_shimmer.dart    # Loading animation
│   │       ├── empty_widget.dart       # Empty state UI
│   │       ├── error_widget.dart       # Error state UI
│   │       ├── offline_banner.dart     # Connection status
│   │       ├── section_header.dart     # Section titles
│   │       ├── segmented_tab.dart      # Tab navigation
│   │       ├── progress_bar_widget.dart # Progress indicator
│   │       └── coming_soon_badge.dart  # Feature badge
│   └── features/                 # Feature modules (Clean Architecture)
│       ├── analysis/             # User analytics & performance analysis
│       │   ├── data/             # Data layer (models, repositories)
│       │   ├── providers/        # Riverpod providers
│       │   └── screens/          # UI screens & widgets
│       ├── auth/                 # Authentication (Login, Register, Verification)
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       ├── contests/             # Contest tracking & details
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       ├── friends/              # Social features
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       ├── home/                 # Home dashboard
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       ├── practice/             # Problem practice & solving
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       ├── profile/              # User profile management
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       ├── settings/             # App settings & preferences
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       ├── upsolve/              # Post-contest problem solving
│       │   ├── data/
│       │   ├── providers/
│       │   └── screens/
│       └── providers/            # Shared/global feature providers
├── assets/
│   └── images/                   # UI images & backgrounds
├── android/                      # Android platform configuration
├── ios/                          # iOS platform configuration
├── web/                          # Web platform configuration
├── macos/                        # macOS platform configuration
├── linux/                        # Linux platform configuration
├── windows/                      # Windows platform configuration
├── test/                         # Unit/Widget tests
├── pubspec.yaml                  # Dependencies & project config
├── analysis_options.yaml         # Dart analyzer settings
└── .env                          # Environment variables (not in repo)

---

## RULES FOR COPILOT

Rule 1: Never create a new widget if one already exists in core/widgets/
Rule 2: Always use AppColors for colors — never hardcode hex values
Rule 3: Always use AppTextStyles for text — never hardcode fontSize or fontWeight
Rule 4: Always use flutter_screenutil — write 16.w not 16, 20.h not 20, 14.sp not 14, 8.r not 8
Rule 5: Every screen must use PageWrapper as root widget
Rule 6: AppBackground is already inside PageWrapper — never add it separately
Rule 7: GlassCard is the only card widget — never create custom containers that look like cards
Rule 8: AppButton is the only button widget — never use ElevatedButton or TextButton directly
Rule 9: AppTextField is the only text field widget — never use TextFormField directly
Rule 10: AuthBottomLayout is shared between Login and Register — never duplicate it
Rule 11: Every import must use package:algolens/ prefix
Rule 12: Never use MediaQuery for sizing — always use ScreenUtil

---

## CORE THEME FILES

### AppColors
FILE: lib/core/theme/app_colors.dart
IMPORT: import 'package:algolens/core/theme/app_colors.dart';
CLASS: AppColors
ALL AVAILABLE VALUES:
  // Backgrounds
  AppColors.bgDark       = Color(0xFF0B1220)
  AppColors.bgMid        = Color(0xFF0D1829)
  AppColors.bgLight      = Color(0xFF101A2E)
  // Glass
  AppColors.glassFill    = Color(0x1FFFFFFF)  // white 12%
  AppColors.glassBorder  = Color(0x33FFFFFF)  // white 20%
  AppColors.glassStrong  = Color(0x26FFFFFF)  // white 15%
  // Electric Blue
  AppColors.primary      = Color(0xFF2563EB)
  AppColors.primaryLight = Color(0xFF3B82F6)
  AppColors.primaryDark  = Color(0xFF1D4ED8)
  AppColors.primaryGlow  = Color(0x332563EB)
  // Semantic
  AppColors.success      = Color(0xFF10B981)
  AppColors.warning      = Color(0xFFF59E0B)
  AppColors.danger       = Color(0xFFEF4444)
  // Text
  AppColors.textPrimary  = Color(0xFFFFFFFF)
  AppColors.textSecondary= Color(0xFFA0AEC0)
  AppColors.textMuted    = Color(0xFF718096)
  AppColors.textHint     = Color(0xFF4A5568)
  // CF Rank Colors
  AppColors.cfNewbie     = Color(0xFF808080)
  AppColors.cfPupil      = Color(0xFF008000)
  AppColors.cfSpecialist = Color(0xFF03A89E)
  AppColors.cfExpert     = Color(0xFF0000FF)
  AppColors.cfCM         = Color(0xFFAA00AA)
  AppColors.cfMaster     = Color(0xFFFF8C00)
  AppColors.cfGM         = Color(0xFFFF0000)
  // Dividers
  AppColors.divider      = Color(0x14FFFFFF)
  AppColors.dividerStrong= Color(0x1FFFFFFF)

### AppTextStyles
FILE: lib/core/theme/app_text_styles.dart
IMPORT: import 'package:algolens/core/theme/app_text_styles.dart';
CLASS: AppTextStyles
ALL AVAILABLE VALUES:
  AppTextStyles.display     // 28sp Inter Bold white
  AppTextStyles.title       // 22sp Inter Bold white
  AppTextStyles.heading     // 18sp Inter w600 white
  AppTextStyles.subheading  // 16sp Inter w600 white
  AppTextStyles.body        // 14sp Inter normal textSecondary
  AppTextStyles.bodyBold    // 14sp Inter w600 white
  AppTextStyles.caption     // 12sp Inter normal textMuted
  AppTextStyles.captionBold // 12sp Inter w600 textSecondary
  AppTextStyles.hint        // 11sp Inter normal textHint
  AppTextStyles.mono        // 14sp JetBrains Mono white
  AppTextStyles.monoLarge   // 28sp JetBrains Mono Bold white
  AppTextStyles.monoSmall   // 12sp JetBrains Mono textSecondary

### AppDecorations
FILE: lib/core/theme/app_decorations.dart
IMPORT: import 'package:algolens/core/theme/app_decorations.dart';
Contains reusable decoration patterns for cards, inputs, and other UI elements with rounded corners and glass effects

---

## CORE WIDGETS - MANDATORY USAGE

### PageWrapper
- **Purpose:** Root widget for every screen in the app
- **Features:** Handles background, padding, and safe area
- **Usage:** Wrap all screen content in this widget
- **DO NOT:** Add AppBackground separately if using PageWrapper

### AppButton
- **Purpose:** Primary button throughout the app
- **Features:** Consistent styling, loading states, custom elevation
- **Use For:** Form submissions, navigation, actions
- **DO NOT:** Use ElevatedButton or TextButton directly

### AppTextField
- **Purpose:** Custom text input field with app styling
- **Features:** Integrated validation, focus states, custom icons
- **Use For:** All text input (login, search, forms)
- **DO NOT:** Use TextFormField or built-in TextField directly

### GlassCard
- **Purpose:** Card container with frosted glass effect
- **Features:** Border, fill, glassmorphism styling
- **Use For:** Data containers, content grouping
- **DO NOT:** Create custom containers that look like cards

### MainScaffold
- **Purpose:** Main app layout with bottom navigation
- **Features:** FAB integration, scaffold management
- **Usage:** Use as base for main navigable screens

### AuthBottomLayout
- **Purpose:** Shared layout for Login and Register screens
- **Features:** Consistent bottom area, button grouping
- **Usage:** Prevents duplication between auth screens

### Other Specialized Widgets

| Widget | Purpose |
|--------|---------|
| RankChip | Display Codeforces rank with color coding |
| ContestCard | Contest information card with countdown |
| ProblemRow | Problem list item row |
| StatCard | Statistics display card |
| UserAvatar | User profile picture wrapper |
| CountdownTimer | Contest countdown timer |
| LoadingShimmer | Loading skeleton animation |
| EmptyWidget | Empty state display |
| ErrorWidget | Error state display |
| OfflineBanner | Network connectivity status |
| SectionHeader | Section title with styling |
| SegmentedTab | Tab navigation component |
| ProgressBarWidget | Progress indicator |
| ComingSoonBadge | Feature availability badge |

---

## FEATURES OVERVIEW

### 1. Authentication (auth/)
**Purpose:** User login, registration, and verification
**Components:**
- Login Screen
- Register Screen
- Email/Phone Verification
- Password Recovery
**Data Models:** User credentials, authentication tokens
**Storage:** Secure token storage using flutter_secure_storage

### 2. Home Dashboard (home/)
**Purpose:** Main entry point showing overview and statistics
**Components:**
- Dashboard overview
- Quick stats display
- Recent contests
- Performance summary
**Features:** Real-time updates, widget refresh

### 3. Contests (contests/)
**Purpose:** Track and manage competitive programming contests
**Components:**
- Upcoming contests list
- Contest details screen
- Contest countdown
- Registration management
- Past contests history
**Data:** Contest schedules, standings, problems
**Platforms Supported:** Codeforces, AtCoder, CodeChef, etc.

### 4. Practice (practice/)
**Purpose:** Problem solving and practice tracking
**Components:**
- Problem list/search
- Problem details with samples
- Code editor integration
- Submission tracking
- Difficulty filters
- Topic/tag filters
**Features:** Bookmarks, notes, solution tracking

### 5. Analysis (analysis/)
**Purpose:** Performance analytics and statistics
**Components:**
- Rating progression charts
- Problem statistics
- Performance metrics
- Success rate analysis
- Contest performance breakdown
**Visualizations:** fl_chart graphs, progress indicators
**Data:** Historical performance, trend analysis

### 6. Profile (profile/)
**Purpose:** User profile and account management
**Components:**
- Profile information display
- Account settings
- Linked platform accounts (CF, CC, etc.)
- Profile statistics
- Achievement badges
**Edit Modes:** Profile picture upload, bio update

### 7. Friends (friends/)
**Purpose:** Social networking features
**Components:**
- Friends list
- Friend requests
- Friend profiles
- Friend statistics comparison
- Follow/Activity feed
**Features:** Real-time sync, notifications

### 8. Upsol

ve (upsolve/)
**Purpose:** Post-contest problem solving and learning
**Components:**
- Failed problems from contests
- Upsolve problems list
- Solution tracking
- Editorial/hints
- Community solutions
**Goal:** Help users learn from mistakes after contests

### 9. Settings (settings/)
**Purpose:** App configuration and preferences
**Components:**
- Theme settings (dark/light mode)
- Notification preferences
- Cache management
- Account linking/unlinking
- About and version info
- Privacy and security settings
**Storage:** Shared preferences, local configuration

---

## APP CONFIGURATION & INITIALIZATION

### main.dart
- Sets device orientation to portrait only
- Configures system UI overlay style (status bar, navigation bar)
- Loads environment variables from .env file
- Initializes Riverpod with ProviderScope
- Sets up ScreenUtil with design size 390x844
- Configures MaterialApp with GoRouter

### Design Size Specification
- **Canvas Width:** 390px
- **Canvas Height:** 844px
- **minTextAdapt:** true (responsive text)
- **splitScreenMode:** false (single screen)

---

## STATE MANAGEMENT WITH RIVERPOD

### Provider Pattern
- **StateProvider:** Mutable simple state
- **StateNotifierProvider:** Complex state with methods
- **FutureProvider:** Async data fetching
- **AsyncValue:** Handles loading, error, data states
- **watch():** Listen to provider changes in build methods
- **read():** Access provider without rebuilding
- **select():** Select specific parts to optimize rebuilds

### Global Providers Location
`lib/features/providers/` - Shared feature providers
`lib/core/providers/` - Global app providers (auth, connectivity, user)

### Best Practices
- Use AsyncValue for handling loading/error states
- Use StateNotifier for complex business logic
- Combine providers with `ref.watch()` for complex derived state
- Use `family()` modifier for parameterized providers

---

## NAVIGATION WITH GO_ROUTER

### Routing Architecture
`lib/core/router/app_router.dart` - Main router configuration
Configured in MaterialApp.router with GoRouter instance

### Route Structure
- **Authentication Routes:** /login, /register, /verify-email
- **Main App Routes:** / (home), /profile, /contests, /practice, /analysis
- **Nested Navigation:** Bottom tabs with nested routes
- **Deep Linking:** Supported for contest and problem links

### Navigation Usage
```dart
context.push('/contests');  // Push new route
context.pop();               // Pop current route
context.go('/');             // Replace current route
GoRouter.of(context).pushNamed('routeName');
```

---

## NETWORK & HTTP

### Dio Configuration
`lib/core/network/` - HTTP client setup
- Base URL from .env file
- Pretty logger for development (pretty_dio_logger)
- Interceptors for auth, error handling
- Timeout configuration
- Custom headers management

### API Communication
- All API calls through Dio instance
- JSON serialization with json_serializable
- Error handling with custom exception classes
- Network connectivity check with connectivity_plus

---

## LOCAL STORAGE

### Isar Database
`lib/core/storage/` - Database configuration
- NoSQL document database
- Type-safe queries
- Real-time watchers
- Collections for: Users, Contests, Problems, Submissions
- Automatic code generation with isar_generator

### Secure Storage
- **Purpose:** Store sensitive data (API tokens, passwords)
- **Package:** flutter_secure_storage
- **Platform-specific:** Keychain (iOS), Keystore (Android)

### SharedPreferences
- User preferences
- App settings
- Non-sensitive cached data
- Theme preferences

---

## ERROR HANDLING & EXCEPTIONS

### Custom Exception Classes
`lib/core/errors/` - Exception definitions
- NetworkException: Network failures
- DatabaseException: Database errors
- AuthenticationException: Auth failures
- ValidationException: Input validation
- ServerException: API errors

### Error Handling Pattern
```dart
try {
  // Operation
} on NetworkException catch (e) {
  // Handle network error
} on DatabaseException catch (e) {
  // Handle database error
}
```

---

## ASSET MANAGEMENT

### Images
Location: `assets/images/`
- App backgrounds
- UI icons
- User avatars
- Contest logos
- Platform icons

### Configuration in pubspec.yaml
```yaml
assets:
  - assets/images/
  - .env
```

---

## BUILD & PLATFORM-SPECIFIC

### Android
`android/` - Android configuration
- build.gradle.kts (Kotlin DSL)
- Minimum SDK, target SDK configuration
- Required permissions in AndroidManifest.xml

### iOS
`ios/` - iOS configuration
- Runner.xcodeproj
- Podfile
- Info.plist settings
- Required capabilities

### Web
`web/` - Web platform
- index.html
- manifest.json (PWA configuration)
- Icon set

### macOS, Linux, Windows
`macos/`, `linux/`, `windows/` - Desktop platforms
- Platform-specific configurations
- CMakeLists.txt for native dependencies

---

## DEVELOPMENT COMMANDS

### Build & Run
```bash
flutter pub get              # Get dependencies
flutter run                  # Run debug build
flutter build apk           # Build Android APK
flutter build ios           # Build iOS app
flutter build web           # Build web version
```

### Code Generation
```bash
flutter pub run build_runner build           # Generate code
flutter pub run build_runner watch           # Watch for changes
flutter pub run build_runner clean           # Clean generated files
```

### Analysis & Testing
```bash
flutter analyze              # Run Dart analyzer
flutter test                 # Run unit tests
flutter test --coverage     # Generate coverage report
```

---

## ENVIRONMENT VARIABLES

### .env File (NOT IN REPO)
```
API_BASE_URL=https://api.example.com
API_KEY=your_api_key
CODEFORCES_API_URL=https://codeforces.com/api
CODECHEF_API_URL=https://api.codechef.com
```

### Loading in App
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiUrl = dotenv.env['API_BASE_URL'] ?? 'default_url';
```

---

## BEST PRACTICES & CONVENTIONS

### Naming Conventions
- **Classes:** PascalCase (e.g., UserProfile, ContestCard)
- **Functions/Variables:** camelCase (e.g., getUserData, isLoading)
- **Constants:** camelCase or UPPER_CASE for compile-time constants
- **Files:** snake_case (e.g., user_profile.dart, contest_card.dart)
- **Widgets:** PascalCase (e.g., HomePage, ContestListScreen)

### File Organization
- One main widget/class per file
- Keep related utilities together
- Separate concerns: data, providers, screens
- Clear import paths with package: prefix

### Code Quality Standards
- Use lints from flutter_lints (3.0.0)
- Run `flutter analyze` before commits
- Follow clean code principles
- Add meaningful comments for complex logic
- Use type annotations consistently

### Responsive Design
- Always use ScreenUtil for sizes (16.w, 20.h, 14.sp, 8.r)
- Never hardcode pixel values
- Test on multiple screen sizes
- Use AppColors and AppTextStyles exclusively

---

## IMPORTANT NOTES

1. **Clean Architecture:** Features follow bloc/provider → data → screens structure
2. **Glassmorphism Design:** App uses frosted glass effects (AppColors.glass* colors)
3. **Competitive Programming Focus:** Codeforces rank colors, contest-specific features
4. **Multi-platform:** Desktop and mobile support built-in
5. **Performance:** Riverpod caching, lazy loading, efficient rebuilds
6. **Accessibility:** Consider screen readers, color contrast, text scaling
7. **Offline Support:** Some features available offline using Isar cache

---

## COMMON PATTERNS

### Async Data Fetching
```dart
final dataProvider = FutureProvider<T>((ref) async {
  return fetchData();
});

// In widget
ref.watch(dataProvider).when(
  loading: () => LoadingShimmer(),
  error: (err, stack) => ErrorWidget(error: err),
  data: (data) => DataWidget(data: data),
)
```

### State Management
```dart
final stateProvider = StateNotifierProvider<MyNotifier, MyState>((ref) {
  return MyNotifier(ref);
});

class MyNotifier extends StateNotifier<MyState> {
  MyNotifier(this.ref) : super(initialState);
  final Ref ref;
  
  void updateState() {
    state = state.copyWith(/* changes */);
  }
}
```

### Navigation
```dart
ElevatedButton(
  onPressed: () => context.push('/contests'),
  child: Text('View Contests'),
)
```

---

## TROUBLESHOOTING COMMON ISSUES

- **Code not generated:** Run `flutter pub run build_runner clean` then `build` again
- **State not updating:** Check if using `watch()` in build, use `select()` for optimization
- **Navigation issues:** Verify route names in app_router.dart
- **Network errors:** Check .env file exists, API_BASE_URL is correct
- **Widget overflow:** Use ScreenUtil units (16.w not 16)
- **Styling issues:** Always use AppColors and AppTextStyles, never hardcode
- **Build errors:** Run `flutter clean` and `flutter pub get` again

---

## PROJECT FEATURES CHECKLIST

Core Features Implemented:
- ✅ Multi-platform support (Android, iOS, Web, Desktop)
- ✅ User authentication with secure token storage
- ✅ Contest tracking and management
- ✅ Problem practice and solving
- ✅ Performance analytics and charts
- ✅ User profiles and social features
- ✅ Notifications and reminders
- ✅ Local caching and offline support
- ✅ Theme customization
- ✅ Text-to-speech for accessibility
- ✅ Screenshots and sharing features
- ✅ Home widget support
- ✅ Background task management
- ✅ Real-time connectivity detection

---

**Last Updated:** April 2026
**Version:** 1.0.0+1
**Status:** Active Development
**Contact:** AlgoLens Development Team
  AppColors.textMuted    = Color(0xFF718096)
  AppColors.textHint     = Color(0xFF4A5568)
  // CF Rank Colors
  AppColors.cfNewbie     = Color(0xFF808080)
  AppColors.cfPupil      = Color(0xFF008000)
  AppColors.cfSpecialist = Color(0xFF03A89E)
  AppColors.cfExpert     = Color(0xFF0000FF)
  AppColors.cfCM         = Color(0xFFAA00AA)
  AppColors.cfMaster     = Color(0xFFFF8C00)
  AppColors.cfGM         = Color(0xFFFF0000)
  // Dividers
  AppColors.divider      = Color(0x14FFFFFF)
  AppColors.dividerStrong= Color(0x1FFFFFFF)

### AppTextStyles
FILE: lib/core/theme/app_text_styles.dart
IMPORT: import 'package:algolens/core/theme/app_text_styles.dart';
CLASS: AppTextStyles
ALL AVAILABLE VALUES:
  AppTextStyles.display     // 28sp Inter Bold white
  AppTextStyles.title       // 22sp Inter Bold white
  AppTextStyles.heading     // 18sp Inter w600 white
  AppTextStyles.subheading  // 16sp Inter w600 white
  AppTextStyles.body        // 14sp Inter normal textSecondary
  AppTextStyles.bodyBold    // 14sp Inter w600 white
  AppTextStyles.caption     // 12sp Inter normal textMuted
  AppTextStyles.captionBold // 12sp Inter w600 textSecondary
  AppTextStyles.hint        // 11sp Inter normal textHint
  AppTextStyles.mono        // 14sp JetBrains Mono white
  AppTextStyles.monoLarge   // 28sp JetBrains Mono Bold white
  AppTextStyles.monoSmall   // 12sp JetBrains Mono textSecondary

### AppDecorations
FILE: lib/core/theme/app_decorations.dart
IMPORT: import 'package:algolens/core/theme/app_decorations.dart';
CLASS: AppDecorations
ALL AVAILABLE METHODS:
  AppDecorations.glassCard({Color? borderColor})     // returns BoxDecoration
  AppDecorations.glassCardStrong({Color? borderColor}) // returns BoxDecoration
  AppDecorations.inputField()                         // returns BoxDecoration
  AppDecorations.primaryButton()                      // returns BoxDecoration
  AppDecorations.outlineButton()                      // returns BoxDecoration

### AppTheme
FILE: lib/core/theme/app_theme.dart
IMPORT: import 'package:algolens/core/theme/app_theme.dart';
CLASS: AppTheme
USAGE: AppTheme.dark

---

## CORE WIDGET FILES

### AppBackground
FILE: lib/core/widgets/app_background.dart
IMPORT: import 'package:algolens/core/widgets/app_background.dart';
CLASS: AppBackground
CONSTRUCTOR: AppBackground({required Widget child})
PURPOSE: Wraps entire screen with bg.png background image
USAGE: Only used inside PageWrapper — never use directly in screens
HOW IT WORKS:
  Stack with two children:
  1. Container SizedBox.expand with DecorationImage AssetImage('assets/images/bg.png') BoxFit.cover
  2. child widget on top
  Fallback if image missing: LinearGradient Color(0xFF0B1220) to Color(0xFF1A3A6B) topRight to bottomLeft

### GlassCard
FILE: lib/core/widgets/glass_card.dart
IMPORT: import 'package:algolens/core/widgets/glass_card.dart';
CLASS: GlassCard
CONSTRUCTOR:
  GlassCard({
    required Widget child,
    Color? borderColor,        // defaults to Colors.white.withOpacity(0.20)
    double? borderRadius,      // defaults to 20.r
    EdgeInsets? padding,       // defaults to EdgeInsets.all(16.r)
    double? blur,              // defaults to 25.0
    VoidCallback? onTap,       // optional tap handler
  })
PURPOSE: The ONLY card widget in the app — all cards use this
HOW IT WORKS:
  GestureDetector (if onTap provided)
  └── ClipRRect borderRadius
      └── BackdropFilter ImageFilter.blur sigmaX 25 sigmaY 25
          └── Container
              decoration: BoxDecoration
                color: Colors.white.withOpacity(0.10)
                borderRadius: same as ClipRRect
                border: Border.all color borderColor width 1.5
                gradient: LinearGradient
                  colors: [white 15%, white 5%]
                  begin: topLeft end: bottomRight
              padding: padding parameter
              child: child parameter

### AppButton
FILE: lib/core/widgets/app_button.dart
IMPORT: import 'package:algolens/core/widgets/app_button.dart';
CLASS: AppButton
CONSTRUCTOR:
  AppButton({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,    // shows CircularProgressIndicator
    bool isOutline = false,    // transparent bg with primary border
    bool isGhost = false,      // no border no bg only text
    double? width,             // defaults to double.infinity
    Color? color,              // overrides default color
  })
PURPOSE: The ONLY button widget in the app — never use ElevatedButton
VISUAL:
  Default: solid AppColors.primary background white text
  isOutline: transparent background AppColors.primary border and text
  isGhost: no background no border AppColors.textSecondary text
  Height always 52.h
  BorderRadius 14.r
  Width double.infinity unless width specified

### AppTextField
FILE: lib/core/widgets/app_text_field.dart
IMPORT: import 'package:algolens/core/widgets/app_text_field.dart';
CLASS: AppTextField
CONSTRUCTOR:
  AppTextField({
    required String hint,
    TextEditingController? controller,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    int? maxLines,
    bool enabled = true,
  })
PURPOSE: The ONLY text field widget — glass frosted input field
VISUAL:
  GlassCard with padding 0
  Inside TextFormField
  Glass background white 8% opacity
  Border white 15% opacity radius 12.r
  White text hint textHint color
  If isPassword: eye toggle icon suffix

### AuthBottomLayout
FILE: lib/core/widgets/auth_bottom_layout.dart
IMPORT: import 'package:algolens/core/widgets/auth_bottom_layout.dart';
CLASS: AuthBottomLayout
CONSTRUCTOR:
  AuthBottomLayout({
    required String primaryButtonLabel,
    required VoidCallback onPrimaryPressed,
    required String switchText,
    required String switchLinkText,
    required VoidCallback onSwitchPressed,
    bool isLoading = false,
  })
PURPOSE: Shared bottom section for BOTH Login and Register screens
LAYOUT:
  Column:
    AppButton(label: primaryButtonLabel, onPressed: onPrimaryPressed, isLoading: isLoading)
    SizedBox height 16.h
    Row centered:
      Text(switchText, style: AppTextStyles.caption)
      SizedBox width 4.w
      GestureDetector onTap onSwitchPressed:
        Text(switchLinkText, style: AppTextStyles.captionBold color AppColors.primary)
IMPORTANT: This widget is placed OUTSIDE GlassCard in auth screens

### PageWrapper
FILE: lib/core/widgets/page_wrapper.dart
IMPORT: import 'package:algolens/core/widgets/page_wrapper.dart';
CLASS: PageWrapper
CONSTRUCTOR:
  PageWrapper({
    required Widget child,
    String? title,
    bool showBackButton = false,
    List<Widget>? actions,
    bool showOfflineBanner = true,
  })
PURPOSE: Root widget for EVERY screen — handles background appbar safearea offline banner
LAYOUT:
  AppBackground
  └── Scaffold transparent background
      AppBar (if title provided):
        transparent background
        elevation 0
        white title text AppTextStyles.heading
        leading back button if showBackButton
        actions if provided
      Body:
        SafeArea
        └── Column:
            OfflineBanner (if showOfflineBanner true)
            Expanded:
              child

### SectionHeader
FILE: lib/core/widgets/section_header.dart
IMPORT: import 'package:algolens/core/widgets/section_header.dart';
CLASS: SectionHeader
CONSTRUCTOR:
  SectionHeader({
    required String title,
    String? actionLabel,
    VoidCallback? onActionTap,
  })
LAYOUT:
  Row mainAxisAlignment spaceBetween:
    Text title AppTextStyles.subheading
    if actionLabel: GestureDetector Text actionLabel AppTextStyles.caption AppColors.primary

### StatCard
FILE: lib/core/widgets/stat_card.dart
IMPORT: import 'package:algolens/core/widgets/stat_card.dart';
CLASS: StatCard
CONSTRUCTOR:
  StatCard({
    required String label,
    required String value,
    Color? valueColor,
    String? sublabel,
    bool isMonospace = false,
  })
LAYOUT:
  GlassCard:
    Column crossAxisAlignment start:
      Text label AppTextStyles.caption
      SizedBox 4.h
      Text value style monoLarge if isMonospace else heading
      if sublabel: Text sublabel AppTextStyles.caption

### RankChip
FILE: lib/core/widgets/rank_chip.dart
IMPORT: import 'package:algolens/core/widgets/rank_chip.dart';
CLASS: RankChip
CONSTRUCTOR:
  RankChip({
    required String rank,
    bool small = false,
  })
STATIC METHOD: RankChip.getRankColor(String rank) returns Color
RANK COLOR LOGIC:
  rank.toLowerCase() contains 'newbie'          → AppColors.cfNewbie
  rank.toLowerCase() contains 'pupil'           → AppColors.cfPupil
  rank.toLowerCase() contains 'specialist'      → AppColors.cfSpecialist
  rank.toLowerCase() contains 'expert'          → AppColors.cfExpert
  rank.toLowerCase() contains 'candidate master'→ AppColors.cfCM
  rank.toLowerCase() contains 'master'          → AppColors.cfMaster
  rank.toLowerCase() contains 'grandmaster'     → AppColors.cfGM
  default                                        → AppColors.textMuted

### UserAvatar
FILE: lib/core/widgets/user_avatar.dart
IMPORT: import 'package:algolens/core/widgets/user_avatar.dart';
CLASS: UserAvatar
CONSTRUCTOR:
  UserAvatar({
    required String handle,
    required String rank,
    double size = 44,
  })
VISUAL:
  Circle container size x size
  Background RankChip.getRankColor(rank) 20% opacity
  Border 2px RankChip.getRankColor(rank) 60% opacity
  Inside Text first 2 chars of handle uppercase AppTextStyles.bodyBold rankColor

### LoadingShimmer
FILE: lib/core/widgets/loading_shimmer.dart
IMPORT: import 'package:algolens/core/widgets/loading_shimmer.dart';
CLASSES:
  ShimmerBox({required double width, required double height, double borderRadius = 12})
  ShimmerCard({double height = 80})
PURPOSE: Loading placeholder matching shape of real content

### AppErrorWidget
FILE: lib/core/widgets/error_widget.dart
IMPORT: import 'package:algolens/core/widgets/error_widget.dart';
CLASS: AppErrorWidget
CONSTRUCTOR: AppErrorWidget({required String message, required VoidCallback onRetry, String retryLabel = 'Try Again'})

### AppEmptyWidget
FILE: lib/core/widgets/empty_widget.dart
IMPORT: import 'package:algolens/core/widgets/empty_widget.dart';
CLASS: AppEmptyWidget
CONSTRUCTOR: AppEmptyWidget({required String title, required String subtitle, String? buttonLabel, VoidCallback? onButtonTap, IconData icon = Icons.inbox_outlined})

### OfflineBanner
FILE: lib/core/widgets/offline_banner.dart
IMPORT: import 'package:algolens/core/widgets/offline_banner.dart';
CLASS: OfflineBanner
CONSTRUCTOR: OfflineBanner()
PURPOSE: Auto shows when no internet detected via connectivity_plus

### ContestCard
FILE: lib/core/widgets/contest_card.dart
IMPORT: import 'package:algolens/core/widgets/contest_card.dart';
CLASS: ContestCard
CONSTRUCTOR:
  ContestCard({
    required Contest contest,
    required VoidCallback onReminderToggle,
    bool isReminderSet = false,
  })
REQUIRES MODEL IMPORT: import 'package:algolens/features/contests/data/models/contest_model.dart';

### ProblemRow
FILE: lib/core/widgets/problem_row.dart
IMPORT: import 'package:algolens/core/widgets/problem_row.dart';
CLASS: ProblemRow
CONSTRUCTOR:
  ProblemRow({
    required Problem problem,
    bool showDifficulty = true,
    bool blindMode = false,
    VoidCallback? onTap,
  })
REQUIRES MODEL IMPORT: import 'package:algolens/features/practice/data/models/problem_model.dart';

### CountdownTimer
FILE: lib/core/widgets/countdown_timer.dart
IMPORT: import 'package:algolens/core/widgets/countdown_timer.dart';
CLASS: CountdownTimer
CONSTRUCTOR: CountdownTimer({required int startTimeSeconds, TextStyle? style})

### ProgressBarWidget
FILE: lib/core/widgets/progress_bar_widget.dart
IMPORT: import 'package:algolens/core/widgets/progress_bar_widget.dart';
CLASS: ProgressBarWidget
CONSTRUCTOR: ProgressBarWidget({required double percentage, required Color color, double height = 8, String? label})

### SegmentedTab
FILE: lib/core/widgets/segmented_tab.dart
IMPORT: import 'package:algolens/core/widgets/segmented_tab.dart';
CLASS: SegmentedTab
CONSTRUCTOR:
  SegmentedTab({
    required List<String> tabs,
    required int selectedIndex,
    required Function(int) onTabSelected,
    List<Color>? activeColors,
  })

### ComingSoonBadge
FILE: lib/core/widgets/coming_soon_badge.dart
IMPORT: import 'package:algolens/core/widgets/coming_soon_badge.dart';
CLASS: ComingSoonBadge
CONSTRUCTOR: ComingSoonBadge({String label = 'Coming Soon'})

---

## DATA MODELS

### UserProfile
FILE: lib/features/profile/data/models/profile_model.dart
IMPORT: import 'package:algolens/features/profile/data/models/profile_model.dart';
CLASS: UserProfile
FIELDS:
  String handle
  int rating
  int maxRating
  String rank
  int problemsSolved
  int contestsParticipated
  int streakDays
  String lastActiveDate
  String avatar
GETTERS:
  Color rankColor  // uses RankChip.getRankColor(rank)
FACTORY: UserProfile.fromJson(Map<String,dynamic> json)

### Contest
FILE: lib/features/contests/data/models/contest_model.dart
IMPORT: import 'package:algolens/features/contests/data/models/contest_model.dart';
CLASS: Contest
FIELDS:
  int contestId
  String name
  String type
  int durationSeconds
  int startTimeSeconds
  int relativeTimeSeconds
GETTERS:
  bool isUpcoming
  bool isLive
  String formattedDuration
  DateTime startDateTime
  String suitabilityLabel  // calculated: Div.1=Too Hard, Div.2=Good Match, else=Moderate
FACTORY: Contest.fromJson(Map<String,dynamic> json)

### WeakTopic
FILE: lib/features/practice/data/models/weak_topic_model.dart
IMPORT: import 'package:algolens/features/practice/data/models/weak_topic_model.dart';
CLASS: WeakTopic
FIELDS:
  String tag
  int totalAttempts
  int solvedCount
  int unsolvedCount
  double acRate
GETTERS:
  String severity      // acRate<30=CRITICAL, <50=HIGH, <70=MEDIUM, else=LOW
  Color severityColor  // CRITICAL=danger, HIGH=warning, MEDIUM=primaryLight, LOW=success
FACTORY: WeakTopic.fromJson(Map<String,dynamic> json)

### Problem
FILE: lib/features/practice/data/models/problem_model.dart
IMPORT: import 'package:algolens/features/practice/data/models/problem_model.dart';
CLASS: Problem
FIELDS:
  int contestId
  String index
  String name
  int rating
  List<String> tags
FACTORY: Problem.fromJson(Map<String,dynamic> json)

### UpsolveItem
FILE: lib/features/upsolve/data/models/upsolve_model.dart
IMPORT: import 'package:algolens/features/upsolve/data/models/upsolve_model.dart';
CLASS: UpsolveItem
FIELDS:
  int contestId
  String index
  String name
  int rating
  List<String> tags
  String bestVerdict
  String url
GETTER:
  Color verdictColor  // WA=danger, TLE=warning, MLE=warning, else=textMuted
CLASS: UpsolveContest
FIELDS:
  String contestId
  List<UpsolveItem> problems
STATIC METHOD: UpsolveContest.fromApiResponse(Map<String,dynamic> json) returns List<UpsolveContest>

### Friend
FILE: lib/features/friends/data/models/friend_model.dart
IMPORT: import 'package:algolens/features/friends/data/models/friend_model.dart';
CLASS: Friend
FIELDS:
  String handle
  int rating
  int maxRating
  String rank
  String avatar
  int contestsParticipated
GETTER: Color rankColor
FACTORY: Friend.fromJson(Map<String,dynamic> json)

### LeaderboardEntry
FILE: lib/features/friends/data/models/leaderboard_model.dart
IMPORT: import 'package:algolens/features/friends/data/models/leaderboard_model.dart';
CLASS: LeaderboardEntry
FIELDS:
  int rank
  String handle
  int rating
  String tier
  int maxRating
GETTER: Color rankColor  // uses tier field
FACTORY: LeaderboardEntry.fromJson(Map<String,dynamic> json)

### RatingPoint
FILE: lib/features/profile/data/models/rating_graph_model.dart
IMPORT: import 'package:algolens/features/profile/data/models/rating_graph_model.dart';
CLASS: RatingPoint
FIELDS:
  int contestId
  String contestName
  int rating
  String date
FACTORY: RatingPoint.fromJson(Map<String,dynamic> json)

### SubmissionStats
FILE: lib/features/profile/data/models/submission_stats_model.dart
IMPORT: import 'package:algolens/features/profile/data/models/submission_stats_model.dart';
CLASS: SubmissionStats
FIELDS:
  int totalSubmissions
  int solvedProblems
  int unSolvedProblems
  Map<String,int> verdictsCount
FACTORY: SubmissionStats.fromJson(Map<String,dynamic> json)

### ContestHistoryItem
FILE: lib/features/profile/data/models/contest_history_model.dart
IMPORT: import 'package:algolens/features/profile/data/models/contest_history_model.dart';
CLASS: ContestHistoryItem
FIELDS:
  int contestId
  String contestName
  int rank
  int oldRating
  int newRating
  int ratingChange
FACTORY: ContestHistoryItem.fromJson(Map<String,dynamic> json)

### ProblemAnalysis
FILE: lib/features/analysis/data/models/analysis_model.dart
IMPORT: import 'package:algolens/features/analysis/data/models/analysis_model.dart';
CLASS: ProblemAnalysis
FIELDS:
  int contestId
  String problemIndex
  String problemName
  String likelyIssue
  String conceptToStudy
  String actionableTip

CLASS: AiAnalysisResponse
FIELDS:
  List<ProblemAnalysis> problemAnalyses
  String overallRecommendation
FACTORY: AiAnalysisResponse.fromJson(Map<String,dynamic> json)

---

## PROVIDERS

### dioClientProvider
FILE: lib/features/profile/providers/profile_provider.dart
IMPORT: import 'package:algolens/features/profile/providers/profile_provider.dart';
Provider<DioClient> dioClientProvider

### authStateProvider
FILE: lib/features/auth/providers/auth_provider.dart
IMPORT: import 'package:algolens/features/auth/providers/auth_provider.dart';
StateNotifierProvider<AuthNotifier, AuthState> authStateProvider
AuthState fields: bool isAuthenticated, String? handle, bool isLoading, String? error

### profileProvider
FILE: lib/features/profile/providers/profile_provider.dart
FutureProvider.family<UserProfile, String> profileProvider
USAGE: ref.watch(profileProvider(handle))

### ratingGraphProvider
FILE: lib/features/profile/providers/profile_provider.dart
FutureProvider.family<List<RatingPoint>, String> ratingGraphProvider

### submissionStatsProvider
FILE: lib/features/profile/providers/profile_provider.dart
FutureProvider.family<SubmissionStats, String> submissionStatsProvider

### contestHistoryProvider
FILE: lib/features/profile/providers/profile_provider.dart
FutureProvider.family<List<ContestHistoryItem>, String> contestHistoryProvider

### upcomingContestsProvider
FILE: lib/features/contests/providers/contest_provider.dart
IMPORT: import 'package:algolens/features/contests/providers/contest_provider.dart';
FutureProvider<List<Contest>> upcomingContestsProvider

### weakTopicsProvider
FILE: lib/features/practice/providers/practice_provider.dart
IMPORT: import 'package:algolens/features/practice/providers/practice_provider.dart';
FutureProvider.family<List<WeakTopic>, String> weakTopicsProvider

### recommendationsProvider
FILE: lib/features/practice/providers/practice_provider.dart
FutureProvider.family<List<Problem>, String> recommendationsProvider

### blindModeProvider
FILE: lib/features/practice/providers/practice_provider.dart
StateProvider<bool> blindModeProvider

### upsolveProvider
FILE: lib/features/upsolve/providers/upsolve_provider.dart
IMPORT: import 'package:algolens/features/upsolve/providers/upsolve_provider.dart';
FutureProvider.family<List<UpsolveContest>, String> upsolveProvider

### friendsProvider
FILE: lib/features/friends/providers/friends_provider.dart
IMPORT: import 'package:algolens/features/friends/providers/friends_provider.dart';
FutureProvider.family<List<Friend>, String> friendsProvider

### leaderboardProvider
FILE: lib/features/friends/providers/friends_provider.dart
FutureProvider.family<List<LeaderboardEntry>, String> leaderboardProvider

### aiAnalysisProvider
FILE: lib/features/analysis/providers/analysis_provider.dart
IMPORT: import 'package:algolens/features/analysis/providers/analysis_provider.dart';
FutureProvider.family<AiAnalysisResponse, String> aiAnalysisProvider

---

## NAVIGATION ROUTES

FILE: lib/core/router/app_router.dart
IMPORT: import 'package:algolens/core/router/app_router.dart';
GoRouter appRouter

ROUTES:
  /splash           → SplashScreen
  /onboarding       → OnboardingScreen
  /login            → LoginScreen
  /register         → RegisterScreen
  /verify-email     → EmailVerificationScreen (query param: email)
  /forgot-password  → ForgotPasswordScreen
  /reset-password   → ResetPasswordScreen
  /home             → HomeScreen (inside ShellRoute)
  /contests         → ContestScreen (inside ShellRoute)
  /contests/all     → AllContestsScreen (inside ShellRoute)
  /practice         → WeakTopicsScreen (inside ShellRoute)
  /practice/recommendations → RecommendationsScreen (inside ShellRoute)
  /upsolve          → UpsolveScreen (inside ShellRoute)
  /profile          → ProfileScreen (inside ShellRoute)
  /friends          → FriendsScreen (inside ShellRoute)
  /comparison       → ComparisonScreen (inside ShellRoute)
  /analysis         → AIAnalysisScreen (inside ShellRoute)
  /settings         → SettingsScreen (inside ShellRoute)

NAVIGATION USAGE:
  context.go('/home')         // replace current route
  context.push('/settings')   // push on stack
  context.pop()               // go back

---

## SCREEN FILES

lib/features/auth/screens/splash_screen.dart → SplashScreen
lib/features/auth/screens/onboarding_screen.dart → OnboardingScreen
lib/features/auth/screens/login_screen.dart → LoginScreen
lib/features/auth/screens/register_screen.dart → RegisterScreen
lib/features/auth/screens/email_verification_screen.dart → EmailVerificationScreen
lib/features/auth/screens/forgot_password_screen.dart → ForgotPasswordScreen
lib/features/auth/screens/reset_password_screen.dart → ResetPasswordScreen
lib/features/home/screens/home_screen.dart → HomeScreen
lib/features/contests/screens/contest_screen.dart → ContestScreen
lib/features/contests/screens/all_contests_screen.dart → AllContestsScreen
lib/features/practice/screens/weak_topics_screen.dart → WeakTopicsScreen
lib/features/practice/screens/recommendations_screen.dart → RecommendationsScreen
lib/features/upsolve/screens/upsolve_screen.dart → UpsolveScreen
lib/features/profile/screens/profile_screen.dart → ProfileScreen
lib/features/friends/screens/friends_screen.dart → FriendsScreen
lib/features/friends/screens/comparison_screen.dart → ComparisonScreen
lib/features/analysis/screens/ai_analysis_screen.dart → AIAnalysisScreen
lib/features/settings/screens/settings_screen.dart → SettingsScreen

---

## MOCK DATA BEHAVIOR

FILE: lib/core/network/mock_interceptor.dart
When APP_ENV=development all API calls are intercepted and return mock data from MockData class.
When APP_ENV=production all API calls go to real backend at BASE_URL.
Switch is done by changing APP_ENV in .env file only.
Zero code changes needed when switching environments.

---

## HOW TO USE THIS FILE IN PROMPTS

Every prompt to Copilot must start with:
"Read CONTEXT.md. Use only widgets, models, and providers defined there. Follow all rules listed in CONTEXT.md."

Then describe only what needs to be built in that specific file.

---

## UI_UX_SPECIFICATIONS
## Copilot must follow every single detail here
## This is the visual bible of AlgoLens app
## Never deviate from these specs

---

### FONT SYSTEM

Package: google_fonts: ^6.2.1
Import: import 'package:google_fonts/google_fonts.dart';

Primary font: Inter — all UI text
Monospace font: JetBrains Mono — all numbers

How to use in AppTextStyles:
Never use fontFamily string directly.
Always use GoogleFonts.inter() and 
GoogleFonts.jetBrainsMono() methods.

Exact TextStyle definitions for AppTextStyles class:

static TextStyle get display => GoogleFonts.inter(
  fontSize: 28.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFFFFFFFF),
  letterSpacing: -0.5,
);

static TextStyle get title => GoogleFonts.inter(
  fontSize: 22.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFFFFFFFF),
  letterSpacing: -0.3,
);

static TextStyle get heading => GoogleFonts.inter(
  fontSize: 18.sp,
  fontWeight: FontWeight.w600,
  color: const Color(0xFFFFFFFF),
  letterSpacing: -0.2,
);

static TextStyle get subheading => GoogleFonts.inter(
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
  color: const Color(0xFFFFFFFF),
);

static TextStyle get body => GoogleFonts.inter(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  color: const Color(0xFFA0AEC0),
);

static TextStyle get bodyBold => GoogleFonts.inter(
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
  color: const Color(0xFFFFFFFF),
);

static TextStyle get caption => GoogleFonts.inter(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: const Color(0xFF718096),
);

static TextStyle get captionBold => GoogleFonts.inter(
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
  color: const Color(0xFFA0AEC0),
);

static TextStyle get hint => GoogleFonts.inter(
  fontSize: 11.sp,
  fontWeight: FontWeight.w400,
  color: const Color(0xFF4A5568),
);

static TextStyle get mono => GoogleFonts.jetBrainsMono(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  color: const Color(0xFFFFFFFF),
);

static TextStyle get monoLarge => GoogleFonts.jetBrainsMono(
  fontSize: 28.sp,
  fontWeight: FontWeight.w700,
  color: const Color(0xFFFFFFFF),
);

static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: const Color(0xFFA0AEC0),
);

Also update AppTheme.dark to use Google Fonts:
textTheme: GoogleFonts.interTextTheme(
  ThemeData.dark().textTheme,
).apply(
  bodyColor: const Color(0xFFA0AEC0),
  displayColor: const Color(0xFFFFFFFF),
),

---

### BACKGROUND SYSTEM

Purpose: Electric blue atmospheric gradient image
visible behind all glass cards on every screen.

Implementation inside AppBackground widget:
Stack with StackFit.expand:
Child 1: Image.asset('assets/images/bg.png')
  fit: BoxFit.cover
  width: double.infinity
  height: double.infinity
Child 2: child widget on top

Fallback if image missing:
Container with LinearGradient:
  begin: Alignment.topRight
  end: Alignment.bottomLeft
  colors: [Color(0xFF1A3A6B), Color(0xFF0B1220), Color(0xFF0D1829)]
  stops: [0.0, 0.4, 1.0]

Critical rule: Background image MUST be visible
behind glass cards. Without it glass blur effect
is completely invisible.

Asset path: assets/images/bg.png
Declare in pubspec.yaml under flutter/assets:
  assets:
    - assets/images/

---

### GLASS CARD VISUAL SPEC

Style: Heavy frosted glass iOS Control Center style.

Exact visual values:
blur sigmaX: 30.0
blur sigmaY: 30.0
background gradient top-left: white 18% opacity
background gradient bottom-right: white 8% opacity
border width: 1.5px
border color default: white 25% opacity
border radius: 20.r
padding default: 16.r

Exact Flutter implementation:
ClipRRect(
  borderRadius: BorderRadius.circular(20.r),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.18),
            Colors.white.withOpacity(0.08),
          ],
        ),
        border: Border.all(
          color: borderColor ?? Colors.white.withOpacity(0.25),
          width: 1.5,
        ),
      ),
      padding: padding ?? EdgeInsets.all(16.r),
      child: child,
    ),
  ),
)

Shadow outside ClipRRect for elevation feel:
BoxShadow(
  color: Colors.black.withOpacity(0.25),
  blurRadius: 20,
  offset: Offset(0, 8),
  spreadRadius: 0,
)

Border color variants:
Default: Colors.white.withOpacity(0.25)
Success: Color(0xFF10B981).withOpacity(0.40)
Warning: Color(0xFFF59E0B).withOpacity(0.40)
Danger:  Color(0xFFEF4444).withOpacity(0.40)
Primary: Color(0xFF2563EB).withOpacity(0.40)

---

### BUTTON VISUAL SPEC

Style: Frosted glass button with blue tint.
Premium glassy feel not flat material design.

PRIMARY BUTTON exact implementation:
Wrap in GestureDetector for scale animation.
AnimatedScale scale: isPressed ? 0.97 : 1.0
duration: 100 milliseconds

SizedBox(
  width: width ?? double.infinity,
  height: 52.h,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(14.r),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2563EB).withOpacity(0.85),
              Color(0xFF1D4ED8).withOpacity(0.90),
            ],
          ),
          border: Border.all(
            color: Color(0xFF3B82F6).withOpacity(0.60),
            width: 1.5,
          ),
        ),
        child: Center(
          child: isLoading
            ? SizedBox(
                width: 20.r,
                height: 20.r,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(label, style: AppTextStyles.bodyBold),
        ),
      ),
    ),
  ),
)

OUTLINE BUTTON exact implementation (isOutline: true):
Same structure but gradient colors:
  Color(0xFFFFFFFF).withOpacity(0.08)
  Color(0xFFFFFFFF).withOpacity(0.04)
Border: Color(0xFF2563EB).withOpacity(0.70) width 1.5
Text color: Color(0xFF3B82F6)

GHOST BUTTON (isGhost: true):
No background no border
Text only in Color(0xFFA0AEC0)
Height 52.h same

Button press animation:
Use StatefulWidget with bool _isPressed
GestureDetector onTapDown sets _isPressed true
GestureDetector onTapUp sets _isPressed false
GestureDetector onTapCancel sets _isPressed false
Wrap button in AnimatedScale:
  scale: _isPressed ? 0.97 : 1.0
  duration: Duration(milliseconds: 100)

---

### TEXT FIELD VISUAL SPEC

Style: Frosted glass input field.

Exact implementation:
ClipRRect(
  borderRadius: BorderRadius.circular(12.r),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1.0,
        ),
      ),
      child: TextFormField(
        style: AppTextStyles.body.copyWith(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.hint,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: isPassword ? eyeToggleIcon : suffixIcon,
        ),
      ),
    ),
  ),
)

Focus state: border color changes to
Color(0xFF2563EB).withOpacity(0.60)
Use FocusNode listener to update border color.

---

### SPACING SYSTEM

Style: Balanced medium spacing.

Screen horizontal padding: 20.w both sides
Screen vertical padding top: 16.h
Gap between cards: 16.h
Gap between sections: 24.h
Gap inside cards between elements: 12.h
Gap between label and value: 4.h
Gap between icon and text: 8.w
Bottom nav height: 64.h
AppBar height: 56.h

---

### ANIMATION SYSTEM

Page transitions: Premium scale + fade like Apple.
Implementation in GoRouter:
CustomTransitionPage with duration 300ms:
  FadeTransition opacity animation
  ScaleTransition scale from 0.95 to 1.0
  Combined using Stack

Code for page transition:
CustomTransitionPage(
  child: child,
  transitionDuration: Duration(milliseconds: 300),
  transitionsBuilder: (context, animation, secondary, child) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0.95,
          end: 1.0,
        ).animate(curved),
        child: child,
      ),
    );
  },
)

Button press animation:
AnimatedScale scale 0.97 on press duration 100ms
Already defined in button spec above.

Cards appear animation:
Use flutter_animate package.
Every GlassCard when it first appears:
.animate()
.fadeIn(duration: 400.ms, curve: Curves.easeOut)
.slideY(
  begin: 0.1,
  end: 0,
  duration: 400.ms,
  curve: Curves.easeOut,
)

Loading shimmer animation:
Use shimmer package Shimmer.fromColors:
  baseColor: Colors.white.withOpacity(0.05)
  highlightColor: Colors.white.withOpacity(0.15)

---

### APPBAR VISUAL SPEC

Every screen AppBar:
backgroundColor: Colors.transparent
elevation: 0
scrolledUnderElevation: 0
centerTitle: false
titleTextStyle: AppTextStyles.heading
leading: if showBackButton IconButton(
  icon: Icon(Icons.arrow_back_ios_new_rounded)
  color: Colors.white
  iconSize: 20.r
  onPressed: context.pop()
)
actions: passed from PageWrapper

---

### BOTTOM NAVIGATION VISUAL SPEC

Use salomon_bottom_bar package.
backgroundColor: Colors.black.withOpacity(0.40)
Apply BackdropFilter blur 20 behind bottom nav.
selectedColor: AppColors.primary Color(0xFF2563EB)
unselectedColor: AppColors.textMuted Color(0xFF718096)
margin: EdgeInsets.symmetric(
  horizontal: 16.w,
  vertical: 12.h,
)
Items:
  Home:     icon Icons.home_outlined
  Contests: icon Icons.event_note_outlined
  Practice: icon Icons.lightbulb_outlined
  Upsolve:  icon Icons.queue_outlined
  Profile:  icon Icons.person_outline_rounded

---

### SCREEN LAYOUT SPECS

ONBOARDING SCREEN layout:
PageWrapper with no title no appbar.
Body: SafeArea Padding horizontal 20.w
Column mainAxisAlignment: spaceBetween
TOP SECTION:
  Spacer flex 2
  Text 'AlgoLens' style display color primary
  SizedBox 8.h
  Text 'Competitive Programming Analytics'
    style body centered
  Spacer flex 3
BOTTOM SECTION:
  AppButton label 'Get Started'
    onPressed navigate to /register
  SizedBox 12.h
  AppButton label 'Login'
    isOutline: true
    onPressed navigate to /login
  SizedBox 40.h

LOGIN SCREEN layout:
PageWrapper title 'Login' showBackButton true
Body: SingleChildScrollView
Padding horizontal 20.w
Column:
  SizedBox 32.h
  GlassCard:
    Text 'Welcome back' style heading
    SizedBox 4.h
    Text 'Sign in to continue' style body
    SizedBox 24.h
    AppTextField hint 'Email Address'
      keyboardType email
      prefixIcon Icon(Icons.email_outlined)
    SizedBox 14.h
    AppTextField hint 'Password'
      isPassword true
      prefixIcon Icon(Icons.lock_outlined)
    SizedBox 8.h
    Align right:
      GestureDetector navigate to /forgot-password
      Text 'Forgot Password?' style caption
        color AppColors.primary
  SizedBox 24.h
  AuthBottomLayout:
    primaryButtonLabel: 'Sign In'
    switchText: 'Don\'t have an account?'
    switchLinkText: 'Register'
    onSwitchPressed: navigate to /register

REGISTER SCREEN layout:
PageWrapper title 'Register' showBackButton true
Body: SingleChildScrollView
Padding horizontal 20.w
Column:
  SizedBox 32.h
  GlassCard:
    Text 'Create Account' style heading
    SizedBox 4.h
    Text 'Join the community' style body
    SizedBox 24.h
    AppTextField hint 'Full Name'
      prefixIcon Icon(Icons.person_outlined)
    SizedBox 14.h
    AppTextField hint 'Email Address'
      keyboardType email
      prefixIcon Icon(Icons.email_outlined)
    SizedBox 14.h
    AppTextField hint 'Password'
      isPassword true
      prefixIcon Icon(Icons.lock_outlined)
  SizedBox 24.h
  AuthBottomLayout:
    primaryButtonLabel: 'Create Account'
    switchText: 'Already have an account?'
    switchLinkText: 'Sign In'
    onSwitchPressed: navigate to /login

---

### PHASE RULES FOR COPILOT

Rule A: Only fix one file at a time.
  Never touch other files unless explicitly asked.

Rule B: Search existing code before writing.
  If widget already exists fix it do not rewrite.
  If logic already exists keep it do not remove.

Rule C: Never remove working code.
  Only add or fix what is broken or missing.

Rule D: After every file fix verify imports.
  All imports must use package:algolens/ prefix.
  All imports must match exact paths in CONTEXT.md.

Rule E: Never use raw hex colors.
  Always use AppColors values.
  Exception: withOpacity calls can use inline values.

Rule F: Never use raw font sizes.
  Always use AppTextStyles values.
  Exception: copyWith to modify existing style.

Rule G: Always use flutter_screenutil suffixes.
  16 becomes 16.w or 16.h or 16.r or 16.sp
  Never use raw numbers for sizing.

Rule H: Test mentally before writing.
  Ask: does this file import everything it uses?
  Ask: does this widget exist in CONTEXT.md?
  Ask: am I duplicating something that exists?

Rule I: Glass effect only works with background.
  Always ensure AppBackground or PageWrapper
  is the root widget of every screen.
  Never build glass cards without background behind.

Rule J: One widget one responsibility.
  GlassCard only handles glass visual.
  AppButton only handles button visual.
  Never mix responsibilities.
