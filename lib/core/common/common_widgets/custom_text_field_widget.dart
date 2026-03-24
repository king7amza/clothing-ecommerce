import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  const CustomTextFieldWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      style: Theme.of(
        context,
      ).textTheme.titleMedium!.copyWith(color: colorScheme.secondary),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.surface,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        border: InputBorder.none,
      ),
    );
  }
}
