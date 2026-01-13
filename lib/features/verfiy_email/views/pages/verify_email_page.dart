import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/verfiy_email/view_models/verify_email_cubit/verify_email_cubit.dart';
import 'package:clothing_ecommerce/features/verfiy_email/views/widgets/resend_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerfiyEmailPage extends StatefulWidget {
  const VerfiyEmailPage({super.key});

  @override
  State<VerfiyEmailPage> createState() => _VerfiyEmailPageState();
}

class _VerfiyEmailPageState extends State<VerfiyEmailPage>
    with WidgetsBindingObserver {
  late VerifyEmailCubit _verifyEmailCubit;

  @override
  void initState() {
    super.initState();
    _verifyEmailCubit = context.read<VerifyEmailCubit>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 👇 فور الرجوع، وَجّه لصفحة التحقق التلقائي
      Navigator.pushNamed(context, '/afterVerifyingEmail');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            // 👇 زرار "Next" محذوف تمامًا
          ],
        ),
      ),
    );
  }
}

// class _VerfiyEmailPageState extends State<VerfiyEmailPage>
//     with WidgetsBindingObserver {
//   late VerifyEmailCubit _verifyEmailCubit;
//   bool _isChecking = false;

//   @override
//   void initState() {
//     super.initState();
//     _verifyEmailCubit = context.read<VerifyEmailCubit>();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   Future<void> _silentCheck([int attempt = 0]) async {
//   if (_isChecking) return;
//   _isChecking = true;

//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     _isChecking = false;
//     return;
//   }

//   try {
//     await user.getIdToken(true);
//     await user.reload();

//     if (user.emailVerified) {
//       _isChecking = false;
//       if (!mounted) return;
//       Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
//       return;
//     }

//     // 👇 retry مرة واحدة بعد 3 ثواني (مخصص لـ Realme)
//     if (attempt < 1) {
//       await Future.delayed(const Duration(seconds: 3));
//       if (mounted) {
//         _isChecking = false;
//         _silentCheck(attempt + 1);
//       }
//     } else {
//       _isChecking = false;
//     }
//   } catch (_) {
//     _isChecking = false;
//   }
// }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _isChecking = false; // إعادة التفعيل عند العودة
//       _silentCheck();
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isChecking) {
//       WidgetsBinding.instance.addPostFrameCallback((_) => _silentCheck());
//     }
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: AppColors.lightGrey,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       backgroundColor: AppColors.lightGrey,
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: size.width * 0.08,
//           vertical: size.height * 0.08,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Verfiy Your Email",
//               style: Theme.of(
//                 context,
//               ).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: size.height * 0.093),
//             Text(
//               "Please check your email to verfiy your account !",
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: size.height * 0.06),
//             BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
//               bloc: _verifyEmailCubit,
//               listenWhen: (previous, current) => current is ResendEmailError,
//               listener: (context, state) {
//                 if (state is ResendEmailError) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(SnackBar(content: Text(state.message)));
//                 }
//               },
//               buildWhen: (previous, current) =>
//                   current is ResendEmailLoading ||
//                   current is ResendEmailSuccess ||
//                   current is ResendEmailError ||
//                   current is VerifyEmailInitial,
//               builder: (context, state) {
//                 if (state is ResendEmailLoading) {
//                   return ResendEmailWidget(isLoading: true);
//                 } else if (state is ResendEmailSuccess) {
//                   return ResendEmailWidget(isEmailResent: true);
//                 }
//                 return ResendEmailWidget(
//                   onTap: () {
//                     _verifyEmailCubit.resendEmailVerification();
//                   },
//                 );
//               },
//             ),
//             Spacer(),
//             BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
//               bloc: _verifyEmailCubit,
//               listenWhen: (previous, current) =>
//                   current is CheckEmailVerificationError ||
//                   current is CheckEmailVerificationSuccess,
//               listener: (context, state) {
//                 if (state is CheckEmailVerificationError) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(SnackBar(content: Text(state.message)));
//                 }
//                 if (state is CheckEmailVerificationSuccess) {
//                   Navigator.pushNamed(context, "/home");
//                 }
//               },
//               buildWhen: (previous, current) =>
//                   current is CheckEmailVerificationLoading ||
//                   current is CheckEmailVerificationSuccess ||
//                   current is CheckEmailVerificationError,
//               builder: (context, state) {
//                 if (state is CheckEmailVerificationLoading) {
//                   return CustomMainButton(isLoading: true);
//                 }
//                 return CustomMainButton(
//                   title: "Next",
//                   onTap: () {
//                     _verifyEmailCubit.checkEmailVerification();
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
