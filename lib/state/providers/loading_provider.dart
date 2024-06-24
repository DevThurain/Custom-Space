import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';

var loadingProvider = Provider<bool>((ref) {
  var authState = ref.watch(authStateProvider);
  return authState.isLoading;
});
