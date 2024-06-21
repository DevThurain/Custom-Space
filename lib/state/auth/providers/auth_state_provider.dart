import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/auth/models/auth_state.dart';
import 'package:photo_space/state/auth/notifiers/auth_state_notifier.dart';

var authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(),
);
