import 'dart:async';

import 'package:flutter/material.dart' as material;

extension GetImageAspectRatioExtension on material.Image {
  Future<double> getAspectRatio() {
    var completer = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (imageInfo, asyncCall) {
          var aspectRatio = imageInfo.image.width / imageInfo.image.height;
          completer.complete(aspectRatio);
        },
      ),
    );

    return completer.future;
  }
}
