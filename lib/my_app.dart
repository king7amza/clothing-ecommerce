import 'package:clothing_ecommerce/core/utils/routes/app_router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clothing Ecommerce',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/bottomNavBar',
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
