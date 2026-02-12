import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/core/common/common_pages/not_found_page.dart';
import 'package:clothing_ecommerce/core/common/common_pages/bottom_nav_bar_page.dart';
import 'package:clothing_ecommerce/features/product_card/views/pages/product_card_page.dart';
import 'package:clothing_ecommerce/features/home/views/pages/home_page.dart';
import 'package:clothing_ecommerce/features/auth/view_models/login_cubit/login_cubit.dart';
import 'package:clothing_ecommerce/features/auth/views/pages/login_pgae.dart';
import 'package:clothing_ecommerce/features/shop/view_models/shop_cubit/shop_cubit.dart';
import 'package:clothing_ecommerce/features/shop/views/pages/catalog_page.dart';
import 'package:clothing_ecommerce/features/shop/views/pages/shop_page.dart';
import 'package:clothing_ecommerce/features/auth/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:clothing_ecommerce/features/auth/views/pages/sign_up_page.dart';
import 'package:clothing_ecommerce/features/auth/view_models/verify_email_cubit/verify_email_cubit.dart';
import 'package:clothing_ecommerce/features/auth/views/pages/verify_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/bottomNavBar":
        return MaterialPageRoute(builder: (_) => const BottomNavBarPage());
      case "/signup":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignUpCubit(),
            child: const SignUpPage(),
          ),
        );
      case "/verifyEmail":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => VerifyEmailCubit(),
            child: const VerifyEmailWatingPage(),
          ),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        );
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomePage());
      case "/shop":
        return MaterialPageRoute(builder: (_) => const ShopPage());
      case "/productCard":
        final product = settings.arguments as Products?;
        return MaterialPageRoute(builder: (_) =>  ProductCardPage(product: product));
      case "/catalog":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final shopCubit = ShopCubit();
              shopCubit.loadPage(20, 82);
              return shopCubit;
            },
            child: const CatalogPage(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
