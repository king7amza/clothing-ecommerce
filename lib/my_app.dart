import 'package:clothing_ecommerce/core/common/common_pages/bottom_nav_bar_page.dart';
import 'package:clothing_ecommerce/core/utils/routes/app_router.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_themes.dart';
import 'package:clothing_ecommerce/features/profile/view_models/theming_cubit/theming_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final themingCubit = ThemingCubit();
        themingCubit.getCurrentTheme();
        return themingCubit;
      },
      child: BlocBuilder<ThemingCubit, ThemingState>(
        buildWhen: (previous, current) =>
            current is CurrentTheme || current is SwitchedToDarkTheme,
        builder: (context, state) {
          if (state is CurrentTheme) {
            final currentTheme = state.theme;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Clothing Ecommerce',
              theme: currentTheme,
              navigatorObservers: [routeObserver],
              // home: const BottomNavBarPage(),
              // initialRoute: "/signup",
              initialRoute: "/login",
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          } else if (state is SwitchedToDarkTheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Clothing Ecommerce',
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              navigatorObservers: [routeObserver],
              // home: const BottomNavBarPage(),
              // initialRoute: "/signup",
              initialRoute: "/login",
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Clothing Ecommerce',
            theme: AppThemes.lightTheme,
            navigatorObservers: [routeObserver],
            // home: const BottomNavBarPage(),
            // initialRoute: "/signup",
            initialRoute: "/login",
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
