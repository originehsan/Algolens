import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/dio_client.dart';

// Shared DIO Client Provider - used by all features
final dioClientProvider = Provider((ref) => DioClient());

// MainScaffold - Bottom navigation index
final mainNavigationIndexProvider = StateProvider<int>((ref) => 0);

// AppTextField focus state
final appTextFieldFocusProvider = StateProvider<bool>((ref) => false);
