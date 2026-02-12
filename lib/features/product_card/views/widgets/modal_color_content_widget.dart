import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/product_card/models/product_colors_model.dart';
import 'package:clothing_ecommerce/features/product_card/view_models/modal_bottom_sheet_cubit/modal_bottom_sheet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalColorContentWidget extends StatelessWidget {
  final ProductColorsModel itemColor;
  // final bool isSelected;
  const ModalColorContentWidget({
    super.key,
    required this.itemColor,
    // required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ModalBottomSheetCubit>(),
      child: BlocBuilder<ModalBottomSheetCubit, ModalBottomSheetState>(
        buildWhen: (previous, current) => current is ModalBottomSheetSuccess,
        builder: (context, state) {
          final isSelected =
              state is ModalBottomSheetSuccess &&
              state.selectedColor?.colorName == itemColor.colorName;
          if (state is ModalBottomSheetSuccess) {
            return DecoratedBox(
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: AppColors.primaryColor, width: 2)
                    : null,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: isSelected
                    ? const EdgeInsets.all(8.0)
                    : const EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    color: itemColor.color,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: itemColor.color,
              borderRadius: BorderRadius.circular(100),
            ),
          );
        },
      ),
    );
  }
}
