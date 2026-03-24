import 'package:flutter/material.dart';

class TopHeadlineWidget extends StatelessWidget {
  final String headline;
  final String subHeadline;
  final VoidCallback onTap;
  const TopHeadlineWidget({
    super.key,
    required this.headline,
    required this.subHeadline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headline,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
              ),
            ),
            Text(
              subHeadline,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: colorScheme.onSurface),
            ),
          ],
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            'View All',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: colorScheme.secondary),
          ),
        ),
      ],
    );
  }
}
