import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SummerSalesBannerWidget extends StatelessWidget {
  const SummerSalesBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
        top: size.height * 0.02,
      ),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SUMMER SALES',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Up to 50% Off',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
