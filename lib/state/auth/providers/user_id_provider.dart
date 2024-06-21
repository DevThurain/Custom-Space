import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';

var userIdProvider = Provider<String?>((ref) => ref.watch(authStateProvider).userId);
