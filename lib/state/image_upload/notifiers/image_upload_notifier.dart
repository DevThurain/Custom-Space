import 'dart:io' show File;
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/constants/firebase_collection_name.dart';
import 'package:photo_space/state/image_upload/constants/constants.dart';
import 'package:photo_space/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:photo_space/state/image_upload/extensions/get_collection_name_from_file_type_extension.dart';
import 'package:photo_space/state/image_upload/extensions/get_image_aspect_ratio_from_uint8list_extension.dart';
import 'package:photo_space/state/image_upload/models/file_type.dart';
import 'package:photo_space/state/post_settings/models/post_setting.dart';
import 'package:photo_space/state/posts/models/post_payload.dart';
import 'package:photo_space/state/posts/typedefs/user_id.dart';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<bool> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    final Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = await img.decodeImageFile(file.path);
        if (fileAsImage == null) {
          isLoading = true;
          throw const CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        thumbnailUint8List = img.encodeJpg(thumbnail);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          quality: Constants.videoThumbnailQuality,
          maxHeight: Constants.videoThumbnailMaxHeight,
        );

        if (thumb == null) {
          throw const CouldNotBuildThumbnailException();
        }
        thumbnailUint8List = thumb;
        break;
    }

    /// generate fileName
    final fileName = const Uuid().v4();

    /// create reference for thumbnail and original file
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName())
        .child(fileName);

    try {
      /// upload thumbnail
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      /// upload original file
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      final thumbnailWithAspectRatio =
          await thumbnailUint8List.getImageWithAspectRatio();

      /// upload post
      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailWithAspectRatio.aspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
        postSettings: postSettings,
      );

      FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
