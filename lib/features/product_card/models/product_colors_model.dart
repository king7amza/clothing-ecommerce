import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProductColorsModel {
  final String colorName;
  final Color color;
  ProductColorsModel({required this.colorName, required this.color});
}

List<ProductColorsModel> productColorsList = [
  ProductColorsModel(colorName: "black", color: AppColors.black),
  ProductColorsModel(colorName: "brown", color: AppColors.brown),
  ProductColorsModel(colorName: "blue", color: AppColors.blue),
  ProductColorsModel(colorName: "green", color: AppColors.green),
  ProductColorsModel(colorName: "red", color: AppColors.red),
];
