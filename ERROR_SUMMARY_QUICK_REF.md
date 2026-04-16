# AlgoLens Error Summary - Quick Reference

## CRITICAL ERRORS (MUST FIX NOW)

### 1. Router File Broken: app_router.dart Line 23
- **Status**: ~100 cascading syntax errors
- **Impact**: App won't compile
- **Fix**: Inspect line 23 for syntax corruption

### 2. Home Screen Broken: home_screen.dart Lines 48-51  
- **Status**: Duplicate PageWrapper() calls
- **Impact**: HomeScreen crashes
- **Fix**: Remove lines 48-49, keep only line 51 PageWrapper

### 3. Generated Model Files Invalid
- **Files**: 11 .g.dart files in features/*/data/models/
- **Status**: Reference non-existent classes
- **Impact**: Type system broken
- **Fix**: Delete all .g.dart files (models use manual factory constructors)

### 4. Contest Screen Widget Error: contest_screen.dart Line 267-268
- **Status**: itemCount/itemBuilder on wrong widget
- **Impact**: Contest screen crashes
- **Fix**: Move or remove these ListView parameters

---

## ERROR BY FILE (ORGANIZED)

### Core Module
- **app_router.dart**: Line 23 - 100+ cascading errors
- **app_theme.dart**: Lines 18, 23 - Color API deprecated
- **app_decorations.dart**: 8× withOpacity() deprecated
- **app_button.dart**: 6× withOpacity() deprecated
- **app_text_field.dart**: 3× withOpacity() deprecated
- **progress_bar_widget.dart**: Unused import "app_colors"

### Features: Auth
- **onboarding_screen.dart**: 2× withOpacity() deprecated

### Features: Analysis  
- **ai_analysis_screen.dart**: Line 81 - provider call error
- **analysis_model.g.dart**: Lines 9, 10, 29, 30, 32, 37 - undefined classes

### Features: Contests
- **contest_screen.dart**: 
  - Lines 267-268 - undefined named parameters (itemCount, itemBuilder)
  - Lines 332, 388 - duplicate _buildAllTab, _buildLiveTab definitions
  - 2× withOpacity() deprecated
  - Unused imports: section_header, coming_soon_badge, contest_model
- **contest_model.dart**: 2× unnecessary braces in string interps
- **contest_model.g.dart**: Lines 9, 9:57, 18:38 - undefined classes
- **all_contests_screen.dart**: 
  - Line 89 - provider call error
  - Line 324 - undefined named parameter 'data'
  - Line 345 - provider call error
  - Lines 490-494 - multiple syntax errors

### Features: Friends
- **friends_screen.dart**: 
  - Lines 48, 49 - unused refresh() results
  - Lines 177, 266 - provider call errors
  - 2× withOpacity() deprecated
- **friend_model.g.dart**: Lines 9, 9:55, 18:37 - undefined classes
- **leaderboard_model.g.dart**: Lines 9, 10, 18 - undefined classes
- **comparison_screen.dart**: Lines 148, 245, 288 - provider call errors

### Features: Home
- **home_screen.dart**: 
  - Lines 48-51 - duplicate PageWrapper, missing child param
  - Line 162 - expected ')' token
  - Lines 54, 55 - unused refresh() results
  - 3× withOpacity() deprecated
- **home_provider.dart**: 4 unused imports (flutter_riverpod, auth_provider, profile_provider, contest_provider)

### Features: Practice
- **weak_topics_screen.dart**: Line 68 - provider call error
- **weak_topic_model.g.dart**: Lines 9, 9:61, 17 - undefined classes
- **problem_model.g.dart**: Lines 9, 9:57, 17 - undefined classes
- **recommendations_screen.dart**: Unused import "problem_model"

### Features: Profile
- **profile_screen.dart**: Line 72 - provider call error
- **profile_model.g.dart**: Lines 9, 9:65, 21 - undefined classes
- **contest_history_model.g.dart**: Lines 9, 10, 19 - undefined classes
- **rating_graph_model.g.dart**: Lines 9, 9:65, 16 - undefined classes
- **submission_stats_model.g.dart**: Lines 9, 10, 17 - undefined classes

### Features: Settings
- **settings_screen.dart**: 
  - Line 80 - BuildContext across async gap (SafeCheck issue)
  - 7× withOpacity() deprecated

### Features: Upsolve
- **upsolve_screen.dart**: Lines 141, 200, 370 - provider call errors
- **upsolve_model.g.dart**: Lines 9, 9:65, 19 - undefined classes

### Features: Offline Banner
- **offline_banner.dart**: 
  - Lines 28, 38 - type mismatch (List vs single ConnectivityResult)
  - 1× withOpacity() deprecated

---

## ERROR PATTERNS & COUNTS

### Provider Invocation Errors (12 total)
- Pattern: "The expression doesn't evaluate to a function, so it can't be invoked"
- Likely cause: Incorrect `.call()` syntax or provider type issue
- Locations: 
  - ai_analysis_screen.dart:81
  - all_contests_screen.dart:89, 345
  - comparison_screen.dart:148, 245, 288
  - friends_screen.dart:177, 266
  - profile_screen.dart:72
  - weak_topics_screen.dart:68
  - upsolve_screen.dart:141, 200, 370

### withOpacity() Deprecation (100+ occurrences)
- All should be replaced with `.withValues(alpha: X)`
- Spread across 24 files

### Model Generation Errors (44 total)
- 11 .g.dart files
- Each has: undefined_class, undefined_function, undefined identifier errors
- Solution: Delete .g.dart files or add @JsonSerializable to models

### prefer_const_constructors (100+ occurrences)
- Add `const` keyword to widget constructors
- Affects all screen files

---

## QUICK FIX CHECKLIST

### PHASE 1: EMERGENCY (Critical - Blocks Compilation)
- [ ] Check app_router.dart line 23 for syntax issues
- [ ] Fix home_screen.dart lines 48-51 (remove duplicate PageWrapper)
- [ ] Delete all .g.dart files from features/*/data/models/
- [ ] Fix contest_screen.dart line 267-268 (itemCount/itemBuilder)

### PHASE 2: HIGH PRIORITY (This Week)
- [ ] Fix all 12 provider invocation errors
- [ ] Fix type mismatch in offline_banner.dart
- [ ] Fix duplicate method definitions in contest_screen.dart
- [ ] Fix home_screen.dart line 162 expected ')'

### PHASE 3: MEDIUM PRIORITY (Next Week)
- [ ] Replace 100+ withOpacity() → withValues()
- [ ] Update color APIs (background → surface, onBackground → onSurface)
- [ ] Remove 10 unused imports
- [ ] Add .ignore() to 6 unused refresh() results

### PHASE 4: LOW PRIORITY (When time allows)
- [ ] Add 100+ const modifiers
- [ ] Fix 2 string interpolation issues
- [ ] Fix BuildContext async gap issue in settings_screen.dart

---

## ERROR DISTRIBUTION BY SEVERITY

| Severity | Count | Files |
|----------|-------|-------|
| CRITICAL | 3 | app_router.dart, home_screen.dart, concert_screen.dart |
| ERROR | 56 | model .g.dart files (11×) + provider calls + syntax |
| WARNING | 33 | unused imports, duplicates, async issues |
| INFO | 200+ | deprecations, const recommendations |

