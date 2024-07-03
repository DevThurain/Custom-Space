import 'dart:io' show File;
import 'package:flutter/foundation.dart' show immutable;
import 'package:photo_space/state/image_upload/models/file_type.dart';

@immutable
class ThumbnailRequest {
  final FileType fileType;
  final File file;

  const ThumbnailRequest({
    required this.fileType,
    required this.file,
  });

  @override
  operator ==(covariant ThumbnailRequest other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType && fileType == other.fileType && file == other.file);
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        fileType,
        file,
      ]);
}
