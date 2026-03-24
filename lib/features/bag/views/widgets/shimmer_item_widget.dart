import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemWidget extends StatelessWidget {
  const ShimmerItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: colorScheme.surface,
      highlightColor: colorScheme.primary,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.01,
        ),
        child: Container(
          width: double.infinity,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(size.height * 0.02),
          ),
        ),
      ),
    );
  }
}
