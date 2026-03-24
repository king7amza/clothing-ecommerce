import 'package:clothing_ecommerce/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';

enum AppThemesEnum { light, dark, blue, orange, purple }

class AppThemesModel {
  final AppThemesEnum themeName;
  final ThemeData appTheme;
  AppThemesModel({required this.appTheme, required this.themeName});
}

List<AppThemesModel> appThemesList = [
  AppThemesModel(
    themeName: AppThemesEnum.light,
    appTheme: AppThemes.lightTheme,
  ),
  AppThemesModel(themeName: AppThemesEnum.dark, appTheme: AppThemes.darkTheme),
  AppThemesModel(themeName: AppThemesEnum.blue, appTheme: AppThemes.blueTheme),
  AppThemesModel(
    themeName: AppThemesEnum.orange,
    appTheme: AppThemes.orangeTheme,
  ),
  AppThemesModel(
    themeName: AppThemesEnum.purple,
    appTheme: AppThemes.purpleTheme,
  ),
];
