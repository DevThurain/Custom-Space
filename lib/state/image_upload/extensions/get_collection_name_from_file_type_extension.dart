import 'package:photo_space/state/image_upload/constants/firebase_path_name.dart';
import 'package:photo_space/state/image_upload/models/file_type.dart';

extension GetCollectionNameFromFileTypeExtension on FileType {
  String collectionName() {
    switch (this) {
      case FileType.image:
        return FirebasePathName.images;

      case FileType.video:
        return FirebasePathName.videos;
    }
  }
}
