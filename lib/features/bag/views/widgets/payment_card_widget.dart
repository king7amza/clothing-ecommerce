import 'package:clothing_ecommerce/features/bag/models/payment_cards_model.dart';
import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  final PaymentCardsModel paymentCard;
  const PaymentCardWidget({super.key, required this.paymentCard});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.03),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    paymentCard.cardColor,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    "assets/images/payments_images/payment_card_templet.png",
                    width: size.width,
                    height: size.height * 0.32,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.02,
                right: -size.width * 0.05,
                child: Image.asset(
                  "assets/images/payments_images/Ellipse.png",
                  width: size.width * 0.4,
                  height: size.width * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -size.width * 0.35,
                left: -size.width * 0.01,
                child: Image.asset(
                  "assets/images/payments_images/Vector.png",
                  width: size.width * 0.7,
                  height: size.height * 0.4,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: size.height * 0.02,
                left: size.width * 0.05,
                child: Image.asset(
                  "assets/images/payments_images/chip.png",
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: size.height * 0.1,
                left: size.width * 0.23,
                child: Text(
                  paymentCard.cardNumber,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Positioned(
                bottom: size.height * 0.05,
                left: size.width * 0.05,
                right: size.width * 0.05,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Card Holder Name",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          paymentCard.cardHolderName,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(width: size.width * 0.09),
                    Column(
                      children: [
                        Text(
                          "Expiry Date",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          paymentCard.expiryDate,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Image.asset(
                      paymentCard.imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.013),
                  child: Center(
                    child: Icon(Icons.check, color: colorScheme.surface),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.05),
              Text(
                "Use as Default Payment Method",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: size.width * 0.05,
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
