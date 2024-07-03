import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Color, Colors;
import 'package:photo_space/extensions/string/as_html_color_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.htmlColorToColor();
  static final facebookColor = '#3b5998'.htmlColorToColor();

  //
  static final seedColor = '#0083B0'.htmlColorToColor();
  static const blackColor = Colors.black;
  static const lightBlackColor = Color(0xFF232327);
  static const normalBlackColor = Color(0xFF1d1d1f);
  static const darkBlackColor = Color(0xFF131315);

  static const whiteColor = Colors.white;

  // framework color
  static final frameworkDarkColor = Colors.grey[850];
  static final frameworkLightColor = Colors.grey[50];

  const AppColors._();
}
