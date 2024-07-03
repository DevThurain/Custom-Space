import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:photo_space/state/image_upload/extensions/get_image_aspect_ratio_extension.dart';
import 'package:photo_space/state/image_upload/models/image_with_aspect_ratio.dart';

extension GetImageAspectRatioFromuint8List on Uint8List {
  Future<ImageWithAspectRatio> getImageWithAspectRatio() async {
    final image = Image.memory(this);
    return ImageWithAspectRatio(
      image: image,
      aspectRatio: await image.getAspectRatio(),
    );
  }
}
