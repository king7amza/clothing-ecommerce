import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomMainButtonWidget extends StatelessWidget {
  final String? title;
  final bool? isLoading;
  final VoidCallback? onTap;
  const CustomMainButtonWidget({
    super.key,
    this.title,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.081,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: isLoading!
              ? const CircularProgressIndicator(color: AppColors.white)
              : Text(
                  title!,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium!.copyWith(color: AppColors.white),
                ),
        ),
      ),
    );
  }
}
