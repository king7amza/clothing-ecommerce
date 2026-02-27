import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/core/common/common_pages/not_found_page.dart';
import 'package:clothing_ecommerce/core/common/common_pages/bottom_nav_bar_page.dart';
import 'package:clothing_ecommerce/features/bag/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/shipping_locations_cubit/shipping_locations_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/detect_location_cubit/detect_location_cubit.dart';
import 'package:clothing_ecommerce/features/bag/views/pages/checkout_page.dart';
import 'package:clothing_ecommerce/features/bag/views/pages/open_street_map_page.dart';
import 'package:clothing_ecommerce/features/bag/views/pages/payment_methods_page.dart';
import 'package:clothing_ecommerce/features/bag/views/pages/shipping_addresses_page.dart';
import 'package:clothing_ecommerce/features/bag/views/pages/success_shipping_page.dart';
import 'package:clothing_ecommerce/features/product_card/views/pages/product_card_page.dart';
import 'package:clothing_ecommerce/features/home/views/pages/home_page.dart';
import 'package:clothing_ecommerce/features/auth/view_models/login_cubit/login_cubit.dart';
import 'package:clothing_ecommerce/features/auth/views/pages/login_pgae.dart';
import 'package:clothing_ecommerce/features/profile/views/pages/my_orders_page.dart';
import 'package:clothing_ecommerce/features/profile/views/pages/user_settings-page.dart';
import 'package:clothing_ecommerce/features/shop/models/category_item_model.dart';
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
      case "/orders":
        return MaterialPageRoute(builder: (_) => const MyOrdersPage());
      case "/success":
        return MaterialPageRoute(builder: (_) => const SuccessShippingPage());
      case "/settings":
        return MaterialPageRoute(builder: (_) => const UserSettingsPage());
      case "/productCard":
        final product = settings.arguments as Products?;
        return MaterialPageRoute(
          builder: (_) => ProductCardPage(product: product),
        );
      case "/checkout":
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PaymentMethodsCubit()),
              BlocProvider(create: (context) => ShippingLocationsCubit()),
            ],
            child: CheckoutPage(),
          ),
        );
      case "/payment":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              return PaymentMethodsCubit()..fetchCards();
            },
            child: PaymentMethodsPage(),
          ),
        );
      case "/address":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              return ShippingLocationsCubit();
            },
            child: ShippingAddressesPage(),
          ),
        );
      case "/map":
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  return DetectLocationCubit();
                },
              ),
              BlocProvider(
                create: (context) {
                  return ShippingLocationsCubit();
                },
              ),
            ],
            child: const OpenStreetMapPage(),
          ),
        );
      case "/catalog":
        final categoryItemName =
            (settings.arguments as CategoryItemModel).title;
        // final int categoryPageNumber =
        //     (settings.arguments as CategoryItemModel).startPage;
        final String categoryEndpoint =
            (settings.arguments as CategoryItemModel).endPoint;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final shopCubit = ShopCubit();
              shopCubit.loadPage(20, 0, categoryEndpoint);
              return shopCubit;
            },
            child: CatalogPage(
              categoryItemName: categoryItemName,
              categoryEndpoint: categoryEndpoint,
            ),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
