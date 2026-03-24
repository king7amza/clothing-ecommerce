import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/auth/view_models/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerHighest,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.secondary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.lightGrey1,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.08,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.height * 0.093),
              Text(
                'Please, enter your email address. You will receive a link to create a new password via email.',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: size.height * 0.02,
                  color: colorScheme.secondary,
                ),
              ),
              SizedBox(height: size.height * 0.08),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: EdgeInsets.all(size.height * 0.018),
                  labelText: 'Email',
                  labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: size.height * 0.02,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.08),
              BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                listenWhen: (previous, current) =>
                    current is ForgotPasswordError,
                listener: (context, state) {
                  if (state is ForgotPasswordError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                bloc: forgotPasswordCubit,
                buildWhen: (previous, current) =>
                    current is ForgotPasswordSuccess ||
                    current is ForgotPasswordError ||
                    current is ForgotPasswordLoading,
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    );
                  } else if (state is ForgotPasswordSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'password reset link sent',
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: colorScheme.secondary),
                          ),
                          content: Text(
                            'please check your email to reset your password',
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: colorScheme.onSurface),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    });
                  }
                  return CustomMainButtonWidget(
                    title: 'Send',
                    onTap: () {
                      forgotPasswordCubit.resetPassword(emailController.text);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
