import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DeliveryItemWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final Color borderColor;

  const DeliveryItemWidget({
    super.key,
    required this.imagePath,
    required this.name,
    this.borderColor = AppColors.white, 
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final effectiveBorderColor = borderColor == AppColors.white 
        ? colorScheme.surface 
        : borderColor;

    return Container(
      width: size.width * 0.25,
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: effectiveBorderColor, width: 4),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurfaceVariant,
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: size.width * 0.2, fit: BoxFit.contain),
          const SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              color: colorScheme.surfaceContainer,
            ),
          ),
        ],
      ),
    );
  }
}