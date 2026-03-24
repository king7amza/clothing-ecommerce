part of 'theming_cubit.dart';

sealed class ThemingState {}

final class ThemingInitial extends ThemingState {}
final class SwitchedToDarkTheme extends ThemingState {
  bool isDarkMode;
  SwitchedToDarkTheme(this.isDarkMode );

  // SwitchedToDarkTheme copyWith({bool? isDarkMode, ThemeMode? themeMode}) =>
  //     SwitchedToDarkTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
}

final class CurrentTheme extends ThemingState {
  final ThemeData theme;
  CurrentTheme({required this.theme});
}
