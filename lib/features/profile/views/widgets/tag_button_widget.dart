import 'package:flutter/material.dart';

class TagButtonWidget extends StatelessWidget {
  final String tagName;
  final bool isSelected;
  const TagButtonWidget({
    super.key,
    required this.tagName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return isSelected
        ? Container(
            height: size.height * 0.05,
            width: size.width * 0.26,
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                tagName,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: size.width * 0.038,
                  color: colorScheme.surfaceTint,
                ),
              ),
            ),
          )
        : Text(
            tagName,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: size.width * 0.038,
              color: colorScheme.secondary,
            ),
          );
  }
}
