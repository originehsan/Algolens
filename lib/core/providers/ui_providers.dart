import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/dio_client.dart';

// Re-export the DioClient provider from dio_client
// All features use this single Dio instance

// MainScaffold - Bottom navigation index
final mainNavigationIndexProvider = StateProvider<int>((ref) => 0);

// AppTextField focus state
final appTextFieldFocusProvider = StateProvider<bool>((ref) => false);
