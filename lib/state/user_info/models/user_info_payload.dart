import 'package:flutter/foundation.dart';
import 'package:photo_space/state/auth/typedefs/user_id.dart';
import 'dart:collection' show MapView;

import 'package:photo_space/state/constants/firebase_field_name.dart';

@immutable
class UserInfoPayload extends MapView<String, String?> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });
}
