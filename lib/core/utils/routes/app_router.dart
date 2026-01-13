import 'package:clothing_ecommerce/core/common/common_pages/not_found_page.dart';
import 'package:clothing_ecommerce/features/home/views/pages/home_page.dart';
import 'package:clothing_ecommerce/features/login/view_models/login_cubit/login_cubit.dart';
import 'package:clothing_ecommerce/features/login/views/pages/login_pgae.dart';
import 'package:clothing_ecommerce/features/sign_up/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:clothing_ecommerce/features/sign_up/views/pages/sign_up_page.dart';
import 'package:clothing_ecommerce/features/verfiy_email/view_models/verify_email_cubit/verify_email_cubit.dart';
import 'package:clothing_ecommerce/features/verfiy_email/views/pages/verify_email_page.dart';
import 'package:clothing_ecommerce/features/verfiy_email/views/widgets/after_verifying_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print("🔍 DEBUG: Navigating to route: ${settings.name}");
    switch (settings.name) {
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
            child: const VerfiyEmailPage(),
          ),
        );
      case "/afterVerifyingEmail":
        return MaterialPageRoute(
          builder: (_) => const AfterVerifyingEmailWidget(),
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
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
