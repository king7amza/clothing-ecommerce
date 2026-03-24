import 'package:flutter/material.dart';

class ResultsTiteldValueRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const ResultsTiteldValueRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: size.width * 0.042,
            color: colorScheme.secondary,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: size.width * 0.042,
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
