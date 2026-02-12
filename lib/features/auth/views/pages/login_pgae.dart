import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/core/common/common_widgets/custom_text_field_widget.dart';
import 'package:clothing_ecommerce/features/auth/view_models/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.lightGrey3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
              "Login",
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: size.height * 0.093),
            Column(
              children: [
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
                Navigator.pushNamed(context, '/forgotPassword');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Your Password?",
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
            BlocConsumer<LoginCubit, LoginState>(
              bloc: loginCubit,
              listenWhen: (previous, current) =>
                  current is LoginError ||
                  current is LoginSuccess ||
                  current is EmailNotVerified,
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is LoginSuccess) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Login Success")));
                  Navigator.pushNamed(context, '/home');
                } else if (state is EmailNotVerified) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                  Navigator.pushNamed(context, '/verifyEmail');
                }
              },
              buildWhen: (previous, current) =>
                  current is LoginLoading || current is LoginSuccess,
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CustomMainButtonWidget(isLoading: true);
                }
                return CustomMainButtonWidget(
                  title: "Login",
                  onTap: () {
                    loginCubit.loginWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  },
                );
              },
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  "Or login with social account",
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
    );
  }
}
