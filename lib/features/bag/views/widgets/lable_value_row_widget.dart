import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LableValueRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const LableValueRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.grey),
        ),
        SizedBox(width: size.width * 0.01),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
