import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/auth/backend/authenticator.dart';
import 'package:photo_space/state/auth/models/auth_result.dart';
import 'package:photo_space/state/auth/models/auth_state.dart';
import 'package:photo_space/state/auth/typedefs/user_id.dart';
import 'package:photo_space/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Authenticator _authenticator = const Authenticator();
  final UserInfoStorage _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        userId: _authenticator.userId,
        isLoading: false,
        result: AuthResult.success,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(isLoading: true);
    AuthResult result = await _authenticator.loginWithGoogle();
    UserId? userid = _authenticator.userId;

    if (result == AuthResult.success && userid != null) {
      await _userInfoStorage.saveUserToFirestore(
        userId: userid,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
    }
    state = AuthState(
      userId: userid,
      isLoading: false,
      result: result,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithIsLoading(isLoading: true);
    AuthResult result = await _authenticator.loginWithFacebook();
    UserId? userid = _authenticator.userId;

    if (result == AuthResult.success && userid != null) {
      await _userInfoStorage.saveUserToFirestore(
        userId: userid,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
    }
    state = AuthState(
      userId: userid,
      isLoading: false,
      result: result,
    );
  }
}
