import 'package:flutter/material.dart';

class SettingsTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String lableText;
  final String hintText;
  const SettingsTextFieldWidget({
    super.key,
    required this.controller,
    required this.lableText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.025,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(size.width * 0.02),
          borderSide: BorderSide.none,
        ),
        label: Text(
          lableText,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        hint: Text(
          hintText,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        filled: true,
        fillColor: colorScheme.surface,
      ),
    );
  }
}
