import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ChooseAddressMethodWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  const ChooseAddressMethodWidget({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(size.width * 0.3),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.08),
            child: Image.asset(
              imagePath,
              width: size.width * 0.24,
              height: size.height * 0.14,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
