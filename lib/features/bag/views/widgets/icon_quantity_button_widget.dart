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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.height * 0.05,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(size.height * 0.05),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurfaceVariant,
              blurRadius: 1,
              offset: Offset(-1, 1),
              spreadRadius: 1,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Icon(
                icon,
                color: colorScheme.onSecondary,
                size: constraints.maxWidth * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}
