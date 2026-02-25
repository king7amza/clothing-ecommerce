import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemWidget extends StatelessWidget {
  const ShimmerItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Shimmer.fromColors(
      baseColor: AppColors.white,
      highlightColor: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.01,
        ),
        child: Container(
          width: double.infinity,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(size.height * 0.02),
          ),
        ),
      ),
    );
  }
}
