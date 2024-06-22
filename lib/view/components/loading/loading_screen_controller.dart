import 'package:flutter/material.dart';

typedef UpdateLoadingScreen = bool Function(String text);
typedef CloseLoadingScreen = bool Function();

@immutable
class LoadingScreenController {
  final UpdateLoadingScreen update;
  final CloseLoadingScreen close;

  const LoadingScreenController({
    required this.update,
    required this.close,
  });
}
