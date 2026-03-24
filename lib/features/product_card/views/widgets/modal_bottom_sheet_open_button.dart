import 'package:flutter/material.dart';

class ModalBottomSheetOpenButton extends StatelessWidget {
  final String? title;
  const ModalBottomSheetOpenButton({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.37,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double fontSize = title == "Extra Extra Large"
                ? constraints.maxWidth * 0.1
                : constraints.maxWidth * 0.15;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: fontSize),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: colorScheme.secondary,
                  size: constraints.maxWidth * 0.2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
