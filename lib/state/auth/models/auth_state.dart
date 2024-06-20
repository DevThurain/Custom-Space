import 'package:flutter/foundation.dart' show immutable;
import 'package:photo_space/state/auth/models/auth_result.dart';
import 'package:photo_space/state/auth/typedefs/user_id.dart';

@immutable
class AuthState {
  final UserId? userId;
  final bool isLoading;
  final AuthResult? result;

  const AuthState({
    required this.userId,
    required this.isLoading,
    required this.result,
  });

  const AuthState.unknown()
      : userId = null,
        isLoading = false,
        result = null;

  AuthState copyWithIsLoading({required bool isLoading}) => AuthState(
        userId: userId,
        isLoading: isLoading,
        result: result,
      );

  @override
  bool operator ==(covariant AuthState other) {
    return (identical(this, other) ||
        (userId == other.userId && isLoading == other.isLoading && result == other.result));
  }

  @override
  int get hashCode => Object.hash(userId, isLoading, result);
}
