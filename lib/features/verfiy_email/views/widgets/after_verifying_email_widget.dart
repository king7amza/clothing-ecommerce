// lib/features/verfiy_email/views/widgets/after_verifying_email_widget.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AfterVerifyingEmailWidget extends StatefulWidget {
  const AfterVerifyingEmailWidget({super.key});

  @override
  State<AfterVerifyingEmailWidget> createState() =>
      _AfterVerifyingEmailWidgetState();
}

class _AfterVerifyingEmailWidgetState extends State<AfterVerifyingEmailWidget> {
  Timer? _verificationTimer;

  @override
  void initState() {
    super.initState();
    _startVerificationPolling();
  }

  void _startVerificationPolling() {
    // 👇 نبدأ التحقق كل 2 ثانية
    _verificationTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      try {
        // 👇 مهم جدًّا لـ Realme: bypass local cache
        await user.getIdToken(true);
        await user.reload();

        if (user.emailVerified) {
          // ✅ الإيميل اتثبت → نوقف الـ polling ونروح للـ home
          _verificationTimer?.cancel();
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      } catch (_) {
        // ignore network or auth errors
      }
    });
  }

  @override
  void dispose() {
    _verificationTimer?.cancel(); // 👈 نضمن إيقاف الـ timer
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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
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