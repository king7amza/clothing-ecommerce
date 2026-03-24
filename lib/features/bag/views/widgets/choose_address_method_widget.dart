import 'package:flutter/material.dart';

class ChooseAddressMethodWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const ChooseAddressMethodWidget({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: size.width * 0.4,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(size.width * 0.1),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.08),
            child: Image.asset(
              imagePath,
              width: size.width * 0.24,
              height: size.height * 0.14,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.05),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: colorScheme.onSurface),
        ),
      ],
    );
  }
}
