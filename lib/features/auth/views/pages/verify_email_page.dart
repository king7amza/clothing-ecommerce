import 'dart:async';

import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/auth/services/auth_services.dart';
import 'package:clothing_ecommerce/features/auth/view_models/verify_email_cubit/verify_email_cubit.dart';
import 'package:clothing_ecommerce/features/auth/views/widgets/resend_email_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailWatingPage extends StatefulWidget {
  const VerifyEmailWatingPage({super.key});

  @override
  State<VerifyEmailWatingPage> createState() => _VerifyEmailWatingPageState();
}

class _VerifyEmailWatingPageState extends State<VerifyEmailWatingPage> {
  late VerifyEmailCubit _verifyEmailCubit;
  Timer? _verificationTimer;

  @override
  void initState() {
    super.initState();
    _verifyEmailCubit = BlocProvider.of<VerifyEmailCubit>(context);
    _startVerificationPolling();
  }
  void _startVerificationPolling() {
    _verificationTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _verificationTimer?.cancel();
        return;
      }
      try {
        final AuthServices authServices = AuthServicesImpl();
        final isVerified = await authServices.checkEmailVerification();
        if (isVerified) {
          _verificationTimer?.cancel();
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(context, '/bottomNavBar', (route) => false);
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _verificationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              "Verify Your Email",
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: size.height * 0.093),
            Text(
              "Please check your email to verify your account!",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: size.height * 0.06),
            BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
              bloc: _verifyEmailCubit,
              listenWhen: (previous, current) => current is ResendEmailError,
              listener: (context, state) {
                if (state is ResendEmailError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              buildWhen: (previous, current) =>
                  current is ResendEmailLoading ||
                  current is ResendEmailSuccess ||
                  current is ResendEmailError ||
                  current is VerifyEmailInitial,
              builder: (context, state) {
                if (state is ResendEmailLoading) {
                  return ResendEmailWidget(isLoading: true);
                } else if (state is ResendEmailSuccess) {
                  return ResendEmailWidget(isEmailResent: true);
                }
                return ResendEmailWidget(
                  onTap: () {
                    _verifyEmailCubit.resendEmailVerification();
                  },
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
