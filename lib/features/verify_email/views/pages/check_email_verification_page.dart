// lib/features/verfiy_email/views/widgets/after_verifying_email_widget.dart
import 'dart:async';
import 'package:clothing_ecommerce/core/common/common_services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckEmailVerificationPage extends StatefulWidget {
  const CheckEmailVerificationPage({super.key});

  @override
  State<CheckEmailVerificationPage> createState() =>
      _CheckEmailVerificationPageState();
}

class _CheckEmailVerificationPageState
    extends State<CheckEmailVerificationPage> {
  Timer? _verificationTimer;

  @override
  void initState() {
    super.initState();
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
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              "Checking email verification...",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              "Please wait until your email is verified.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
