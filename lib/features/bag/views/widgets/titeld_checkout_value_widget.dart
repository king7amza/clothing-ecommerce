import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TiteldCheckoutValueWidget extends StatelessWidget {
  final String? title;
  final Widget value;
  const TiteldCheckoutValueWidget({super.key, this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        value,
      ],
    );
  }
}
