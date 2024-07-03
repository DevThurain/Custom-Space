import 'package:flutter/material.dart';
import 'package:photo_space/view/constants/app_colors.dart';

class AppTheme {
  // AppTheme._();
  // static final _internal = AppTheme._();
  // factory AppTheme.instance() => _internal;

  static get customLightTheme => ThemeData.light().copyWith(
        primaryColor: AppColors.seedColor,
        // scaffoldBackgroundColor: AppColors.frameworkLightColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
        ),
      );

  static get customDarkTheme => ThemeData.dark().copyWith(
        primaryColor: AppColors.seedColor,
        // scaffoldBackgroundColor: AppColors.frameworkDarkColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
          surface: AppColors.lightBlackColor,
        ),
      );
}
