import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/bag/models/payment_cards_model.dart';
import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  final PaymentCardsModel paymentCard;
  const PaymentCardWidget({super.key, required this.paymentCard});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
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
                    width: double.infinity,
                    height: 370,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/payments_images/Ellipse.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/payments_images/Vector.png",
                  width: 400,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 60,
                left: 60,
                child: Image.asset(
                  "assets/images/payments_images/chip.png",
                  width: 55,
                  height: 55,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 150,
                left: 130,
                child: Text(
                  paymentCard.cardNumber,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 60,
                right: 60,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Card Holder Name",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          paymentCard.cardHolderName,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: Colors.white,
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          paymentCard.expiryDate,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .copyWith(
                                color: Colors.white,
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
          Row(
            children: [
              Container(
                width: size.width * 0.07,
                height: size.height * 0.04,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Icon(Icons.check, color: Colors.white)),
              ),
              SizedBox(width: size.width * 0.08),
              Text(
                "Use as Default Payment Method",
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
