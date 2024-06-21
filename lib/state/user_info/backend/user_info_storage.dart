import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:photo_space/state/auth/typedefs/user_id.dart';
import 'package:photo_space/state/constants/firebase_collection_name.dart';
import 'package:photo_space/state/constants/firebase_field_name.dart';
import 'package:photo_space/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserToFirestore({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userData.docs.isNotEmpty) {
        // user already exists
        await userData.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });
        return true;
      } else {
        // create new user
        var payload = UserInfoPayload(
          userId: userId,
          displayName: displayName,
          email: email,
        );

        await FirebaseFirestore.instance.collection(FirebaseCollectionName.users).add(payload);
        return true;
      }
    } on FirebaseException catch (e) {
      debugPrintStack(stackTrace: e.stackTrace);
      return false;
    }
  }

}
