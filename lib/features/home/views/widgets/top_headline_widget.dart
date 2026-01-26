import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TopHeadlineWidget extends StatelessWidget {
  final String headline;
  final String subHeadline;
  final VoidCallback onTap;
  const TopHeadlineWidget({
    super.key,
    required this.headline,
    required this.subHeadline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headline,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Text(
              subHeadline,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            'View All',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
