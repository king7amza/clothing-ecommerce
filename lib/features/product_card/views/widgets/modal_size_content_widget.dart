import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/product_card/models/products_sizes_model.dart';
import 'package:clothing_ecommerce/features/product_card/view_models/modal_bottom_sheet_cubit/modal_bottom_sheet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalSizeContentWidget extends StatelessWidget {
  final ProductSizesModel sizeItem;
  // final bool isSelected;
  const ModalSizeContentWidget({
    super.key,
    required this.sizeItem,
    // required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ModalBottomSheetCubit>(),
      child: BlocBuilder<ModalBottomSheetCubit, ModalBottomSheetState>(
        buildWhen: (previous, current) => current is ModalBottomSheetSuccess,
        builder: (_, state) {
          final isSelected =
              state is ModalBottomSheetSuccess &&
              state.selectedSize?.size == sizeItem.size;
          if (state is ModalBottomSheetSuccess) {
            return Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? AppColors.white : AppColors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  sizeItem.size,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                ),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.grey),
            ),
            child: Center(
              child: Text(
                sizeItem.size,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppColors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
