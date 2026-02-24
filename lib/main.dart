import 'package:clothing_ecommerce/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Stripe.publishableKey =
  //     'pk_test_51T0wmTFobUjvEthfNqCerKYM7mgkp3EAx4xyg2IQApsGCPDKgnl2NK9reLSgGjYew0xpLwjQyyooSkzG2kiwRkvR00Ese3wgbY';
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}
