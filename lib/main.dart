import 'package:clothing_ecommerce/my_app.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late Cloudinary cloudinary;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  final String? apiKey = dotenv.env['CLOUDINARY_API_KEY'];
  final String? apiSecret = dotenv.env['CLOUDINARY_API_SECRET'];
  final String? cloudName = dotenv.env['CLOUD_NAME'];

  if (apiKey == null || apiSecret == null || cloudName == null) {
    debugPrint('❌ Error: Cloudinary credentials are missing in .env file!');
  }
  cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://$apiKey:$apiSecret@$cloudName',
  );
  cloudinary.config.urlConfig.secure = true;
  // Stripe.publishableKey =
  //     'publishableKey';
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: ThemeMode.system == ThemeMode.dark
          ? Brightness.light
          : Brightness.dark,
    ),
  );
  runApp(const MyApp());
}
