import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/constants/firebase_collection_name.dart';
import 'package:photo_space/state/constants/firebase_field_name.dart';
import 'package:photo_space/state/posts/models/post.dart';

var allPostProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final streamController = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.posts,
      )
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .snapshots()
      .listen((snapShot) {
    final posts = snapShot.docs.map(
      (doc) => Post(
        postId: doc.id,
        json: doc.data(),
      ),
    );
    streamController.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    streamController.close();
  });

  return streamController.stream;
});
