import 'package:flutter/material.dart';

class AddNewCardTextFieldWidget extends StatelessWidget {
  final String lableText;
  final String hintText;
  final TextEditingController controller;

  const AddNewCardTextFieldWidget({
    super.key,
    required this.lableText,
    required this.hintText,
    required this.controller,
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
