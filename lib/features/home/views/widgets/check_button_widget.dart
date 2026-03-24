import 'package:flutter/material.dart';

class CheckButtonWidget extends StatelessWidget {
  const CheckButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          "Check",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(color: colorScheme.onPrimary),
        ),
      ),
    );
  }
}
