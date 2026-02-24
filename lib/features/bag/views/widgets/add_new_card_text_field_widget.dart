import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AddNewCardTextFieldWidget extends StatelessWidget {
  final String lableText;
  final String hintText;
  final TextEditingController controller;
  const AddNewCardTextFieldWidget({
    super.key,
    required this.lableText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.width * 0.02),
          borderSide: BorderSide.none,
        ),
        label: Text(
          lableText,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        hint: Text(
          hintText,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
    );
  }
}
