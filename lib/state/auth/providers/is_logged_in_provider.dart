import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/auth/models/auth_result.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';

var isLoggedInProvider = Provider<bool>((ref) {
  var authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
