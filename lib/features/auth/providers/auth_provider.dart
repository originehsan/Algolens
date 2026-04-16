import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:algolens/core/storage/secure_storage.dart';
import 'package:algolens/features/auth/data/repositories/auth_repository.dart';

class AuthState {
  final bool isAuthenticated;
  final String? handle;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.handle,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? handle,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      handle: handle ?? this.handle,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await SecureStorage.isLoggedIn();
    if (isLoggedIn) {
      final handle = await SecureStorage.getHandle();
      state = state.copyWith(
        isAuthenticated: true,
        handle: handle ?? 'ehsan_cf',
      );
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    try {
      final tokens = await _repository.login(
        email: email,
        password: password,
      );
      await SecureStorage.saveAccessToken(
        tokens['accessToken']!,
      );
      await SecureStorage.saveRefreshToken(
        tokens['refreshToken']!,
      );
      // Save default CF handle for mock mode
      await SecureStorage.saveHandle('ehsan_cf');
      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        handle: 'ehsan_cf',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    try {
      await _repository.register(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final refreshToken = await SecureStorage.getRefreshToken();
      if (refreshToken != null) {
        await _repository.logout(refreshToken);
      }
    } catch (_) {
      // Ignore logout errors
    } finally {
      await SecureStorage.clearAll();
      state = const AuthState();
    }
  }

  void updateHandle(String handle) {
    state = state.copyWith(handle: handle);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(authRepositoryProvider),
  );
});
