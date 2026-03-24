import 'package:flutter/material.dart';

class TiteldCheckoutValueWidget extends StatelessWidget {
  final String? title;
  final Widget value;
  const TiteldCheckoutValueWidget({super.key, this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        value,
      ],
    );
  }
}
