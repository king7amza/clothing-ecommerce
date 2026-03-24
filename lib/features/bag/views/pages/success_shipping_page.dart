import 'package:clothing_ecommerce/core/common/common_widgets/custom_main_button_widget.dart';
import 'package:clothing_ecommerce/features/profile/model/user_orders_model.dart';
import 'package:flutter/material.dart';

class SuccessShippingPage extends StatelessWidget {
  const SuccessShippingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    debugPrint(
      "Order Brand: ${userOrdersLogs[0].bagItems[0].product.brand}",
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    "Your order will be delivered soon.\nThank you for choosing our app!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: CustomMainButtonWidget(
                title: 'CONTINUE SHOPPING',
                onTap: () {
                  Navigator.pushNamed(context, '/bottomNavBar');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
