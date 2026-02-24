import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class IconQuantityButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const IconQuantityButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(size.height * 0.05),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 1,
              offset: Offset(-1, 1),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.013),
            child: Icon(icon, color: AppColors.darkGrey),
          ),
        ),
      ),
    );
  }
}
