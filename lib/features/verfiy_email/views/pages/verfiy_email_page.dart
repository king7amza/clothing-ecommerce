import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/verfiy_email/view_models/verify_email_cubit/verify_email_cubit.dart';
import 'package:clothing_ecommerce/features/verfiy_email/views/widgets/resend_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerfiyEmailPage extends StatelessWidget {
  const VerfiyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final verifyEmailCubit = BlocProvider.of<VerifyEmailCubit>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.lightGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.lightGrey,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verfiy Your Email",
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: size.height * 0.093),
            Column(children: [SizedBox(height: size.height * 0.023)]),
            SizedBox(height: size.height * 0.06),
            BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
              bloc: verifyEmailCubit,
              listenWhen: (previous, current) => current is ResendEmailError,
              listener: (context, state) {
                if (state is ResendEmailError) {
                  debugPrint("Error ya hamza : ${state.message}");
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              buildWhen: (previous, current) =>
                  current is ResendEmailLoading ||
                  current is ResendEmailSuccess,
              builder: (context, state) {
                if (state is ResendEmailLoading) {
                  return ResendEmailWidget(isLoading: true);
                } else if (state is ResendEmailSuccess) {
                  return ResendEmailWidget(isEmailResent: true);
                }
                return ResendEmailWidget(
                  onTap: () {
                    verifyEmailCubit.resendEmailVerification();
                  },
                );
              },
            ),
            Spacer(),
            BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
              bloc: verifyEmailCubit,
              listenWhen: (previous, current) =>
                  current is CheckEmailVerificationError ||
                  current is CheckEmailVerificationSuccess,
              listener: (context, state) {
                if (state is CheckEmailVerificationError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is CheckEmailVerificationSuccess) {
                  Navigator.pushNamed(context, "/login");
                }
              },
              buildWhen: (previous, current) =>
                  current is CheckEmailVerificationLoading ||
                  current is CheckEmailVerificationSuccess,
              builder: (context, state) {
                if (state is CheckEmailVerificationLoading) {
                  return CustomMainButton(isLoading: true);
                }
                return CustomMainButton(
                  title: "Next",
                  onTap: () {
                    verifyEmailCubit.checkEmailVerification();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
