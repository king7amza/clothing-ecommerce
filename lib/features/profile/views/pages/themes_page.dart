import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_themes.dart';
import 'package:clothing_ecommerce/features/profile/model/app_themes_model.dart';
import 'package:clothing_ecommerce/features/profile/view_models/theming_cubit/theming_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemingCubit themeCubit = context.read<ThemingCubit>();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Themes",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: colorScheme.secondary),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surfaceContainerHighest,
      ),
      backgroundColor: colorScheme.surfaceContainerHighest,
      body: GridView.builder(
        itemCount: appThemesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final ThemeData appTheme = appThemesList[index].appTheme;
          final AppThemesEnum appThemeName = appThemesList[index].themeName;
          Color themeColor = appThemesList[index].appTheme.colorScheme.primary;
          if (appTheme == AppThemes.lightTheme) {
            themeColor = appTheme.colorScheme.onPrimary;
          } else if (appTheme == AppThemes.darkTheme) {
            themeColor = appTheme.colorScheme.surfaceTint;
          } else {
            themeColor = appTheme.colorScheme.primary;
          }
          return InkWell(
            onTap: () {
              themeCubit.switchFromMultipleThemes(appThemeName.name);
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colorScheme.onPrimary, width: 2),
              ),
              child: Center(
                child: Text(
                  "Theme",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: appTheme == AppThemes.lightTheme
                        ? AppColors.black
                        : colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
