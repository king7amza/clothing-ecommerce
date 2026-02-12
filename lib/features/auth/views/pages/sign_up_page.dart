import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/common/common_widgets/custom_text_field_widget.dart';
import 'package:clothing_ecommerce/features/auth/view_models/sign_up_cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final signUpCubit = BlocProvider.of<SignUpCubit>(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("do you want to exit?"),
            content: const Text("are you sure you want to exit?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.lightGrey3,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.height * 0.093),
              Column(
                children: [
                  CustomTextFieldWidget(
                    hintText: "Name",
                    labelText: "Name",
                    controller: _nameController,
                  ),
                  SizedBox(height: size.height * 0.023),
                  CustomTextFieldWidget(
                    hintText: "Email",
                    labelText: "Email",
                    controller: _emailController,
                  ),
                  SizedBox(height: size.height * 0.023),
                  CustomTextFieldWidget(
                    hintText: "Password",
                    labelText: "Password",
                    controller: _passwordController,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.023),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: AppColors.primaryColor),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.023),
              BlocConsumer<SignUpCubit, SignUpState>(
                bloc: signUpCubit,
                listenWhen: (previous, current) =>
                    current is SignUpError || current is SignUpSuccess,
                listener: (context, state) {
                  if (state is SignUpError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is SignUpSuccess) {
                    Navigator.pushNamed(context, '/verifyEmail');
                  }
                },
                buildWhen: (previous, current) =>
                    current is SignUpLoading ||
                    current is SignUpSuccess ||
                    current is SignUpError,
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return CustomMainButtonWidget(isLoading: true);
                  }
                  return CustomMainButtonWidget(
                    title: "Sign Up",
                    onTap: () {
                      signUpCubit.signUpWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        name: _nameController.text,
                      );
                    },
                  );
                },
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    "Or sign up with social account",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.058),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height * 0.076,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset("assets/images/google.png"),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Container(
                        height: size.height * 0.076,
                        width: size.width * 0.2,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Image.asset("assets/images/facebook.png"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
