import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  const CustomTextFieldWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: AppColors.grey),
        hintStyle: TextStyle(color: AppColors.grey),
        border: InputBorder.none,
      ),
    );
  }
}
