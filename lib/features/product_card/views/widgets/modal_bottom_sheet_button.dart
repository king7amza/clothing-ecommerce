import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetButton extends StatelessWidget {
  final String? title;
  const ModalBottomSheetButton({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.37,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!, style: Theme.of(context).textTheme.titleMedium),
            Icon(Icons.keyboard_arrow_down_sharp, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}
