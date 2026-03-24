import 'package:flutter/material.dart';

class CustomMainButtonWidget extends StatelessWidget {
  final String? title;
  final bool? isLoading;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  const CustomMainButtonWidget({
    super.key,
    this.title,
    this.isLoading = false,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.081,
        decoration: BoxDecoration(
          color: backgroundColor ?? colorScheme.primary,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: isLoading!
              ? CircularProgressIndicator(color: colorScheme.onPrimary)
              : Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}
