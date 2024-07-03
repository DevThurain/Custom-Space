import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:photo_space/state/image_upload/extensions/get_image_aspect_ratio_extension.dart';
import 'package:photo_space/state/image_upload/models/file_type.dart';
import 'package:photo_space/state/image_upload/models/image_with_aspect_ratio.dart';
import 'package:photo_space/state/image_upload/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

var thumbnailProvider = FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
  (ref, request) async {
    final material.Image image;

    switch (request.fileType) {
      case FileType.image:
        image = Image.file(request.file);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: request.file.path,
          imageFormat: ImageFormat.JPEG,
          quality: 75,
        );
        if (thumb == null) {
          throw const CouldNotBuildThumbnailException();
        }
        image = Image.memory(
          thumb,
          fit: BoxFit.fitHeight,
        );
        break;
    }
    var aspectRatio = await image.getAspectRatio();

    return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
  },
);
