import 'package:clothing_ecommerce/core/utils/themes/app_themes.dart';
import 'package:clothing_ecommerce/features/profile/model/app_themes_enum.dart';
import 'package:clothing_ecommerce/features/profile/services/local_database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theming_state.dart';

class ThemingCubit extends Cubit<ThemingState> {
  ThemingCubit() : super(ThemingInitial());

  ThemeData _currentThemeObject = AppThemes.lightTheme;
  bool isDarkMode = false;
  final LocalDatabaseServices localDatabaseServices = LocalDatabaseServices();
  Future<void> switchFromMultipleThemes(String themeName) async {
    localDatabaseServices.setCurrentTheme(themeName);
    isDarkMode == false;
    await getCurrentTheme();
  }

  Future<void> toggleToDarkTheme() async {
    isDarkMode = !isDarkMode;
    isDarkMode == true
        ? localDatabaseServices.setCurrentTheme("dark")
        : localDatabaseServices.setCurrentTheme("light");
    emit(SwitchedToDarkTheme(isDarkMode));
  }

  Future<void> getCurrentTheme() async {
    final currentThemeName = await localDatabaseServices.getCurrentTheme();
    final AppThemesEnum currentThemeEnum = AppThemesEnum.values.byName(
      currentThemeName ?? "light",
    );
    switch (currentThemeEnum) {
      case AppThemesEnum.light:
        _currentThemeObject = AppThemes.lightTheme;
        emit(CurrentTheme(theme: _currentThemeObject));
        break;
      case AppThemesEnum.dark:
        _currentThemeObject = AppThemes.darkTheme;
        emit(CurrentTheme(theme: _currentThemeObject));
        emit(SwitchedToDarkTheme(true));
        isDarkMode = true;
        break;
      case AppThemesEnum.blue:
        _currentThemeObject = AppThemes.blueTheme;
        emit(CurrentTheme(theme: _currentThemeObject));
        break;
      case AppThemesEnum.orange:
        _currentThemeObject = AppThemes.orangeTheme;
        emit(CurrentTheme(theme: _currentThemeObject));
        break;
      case AppThemesEnum.purple:
        _currentThemeObject = AppThemes.purpleTheme;
        emit(CurrentTheme(theme: _currentThemeObject));
        break;
    }
  }
}
