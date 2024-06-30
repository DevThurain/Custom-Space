import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter/foundation.dart' show immutable;
import 'package:photo_space/state/auth/typedefs/user_id.dart';
import 'package:photo_space/state/image_upload/models/file_type.dart';
import 'package:photo_space/state/post_settings/models/post_setting.dart';
import 'package:photo_space/state/posts/models/post_key.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSetting, bool> postSettings,
  }) : super(
          {
            PostKey.userId: userId,
            PostKey.message: message,
            PostKey.createdAt: FieldValue.serverTimestamp(),
            PostKey.thumbnailUrl: thumbnailUrl,
            PostKey.fileUrl: fileUrl,
            PostKey.fileType: fileType.name,
            PostKey.fileName: fileName,
            PostKey.aspectRatio: aspectRatio,
            PostKey.thumbnailStorageId: thumbnailStorageId,
            PostKey.originalFileStorageId: originalFileStorageId,
            PostKey.postSettings: {
              // this code is correct because
              // we sent to server allow_like = true format
              // no need to pass whole PageSetting just storage key
              // this logic also apply in post.dart
              for (final postSetting in postSettings.entries)
                postSetting.key.storageKey: postSetting.value,
            },
            // PostKey.postSettings : postSettings,
          },
        );
}
