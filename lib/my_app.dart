import 'package:clothing_ecommerce/core/common/common_pages/bottom_nav_bar_page.dart';
import 'package:clothing_ecommerce/core/utils/routes/app_router.dart';
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clothing Ecommerce',
      // theme: ThemeData(primarySwatch: Colors.blue),
      navigatorObservers: [routeObserver],
      home: const BottomNavBarPage(),
      // initialRoute: "/signup",
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
