import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SuccessShippingPage extends StatelessWidget {
  const SuccessShippingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Image.asset(
                'assets/images/payments_images/success.png',
                width: size.width * 0.8,
                height: size.height * 0.3,
              ),
              SizedBox(height: size.height * 0.05),
              Text(
                'Success!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Your order will be delivered soon.\nThank you for choosing our app!",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.black),
              ),
              ]),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
              child: CustomMainButtonWidget(title: 'CONTINUE SHOPPING', onTap: () {
                Navigator.pushNamed(context, '/bottomNavBar');
              }),
            ),
          ],
        ),
      ),
    );
  }
}
