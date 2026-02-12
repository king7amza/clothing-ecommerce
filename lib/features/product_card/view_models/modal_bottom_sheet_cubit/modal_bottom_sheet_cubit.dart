import 'package:clothing_ecommerce/features/product_card/models/product_colors_model.dart';
import 'package:clothing_ecommerce/features/product_card/models/products_sizes_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'modal_bottom_sheet_state.dart';

class ModalBottomSheetCubit extends Cubit<ModalBottomSheetState> {
  ModalBottomSheetCubit() : super(ModalBottomSheetInitial());

  void toggleSize(ProductSizesModel selectedSize) {
    if (state is ModalBottomSheetSuccess) {
      final currentSize = (state as ModalBottomSheetSuccess).selectedSize;
      if (currentSize == selectedSize) {
        emit(
          ModalBottomSheetSuccess(
            selectedSize: null,
            selectedColor: (state as ModalBottomSheetSuccess).selectedColor,
          ),
        );
      } else {
        emit(
          ModalBottomSheetSuccess(
            selectedSize: selectedSize,
            selectedColor: (state as ModalBottomSheetSuccess).selectedColor,
          ),
        );
      }
    } else {
      emit(ModalBottomSheetSuccess(selectedSize: selectedSize, selectedColor: null));
    }
  }

  void toggleColor(ProductColorsModel selectedColor) {
    if (state is ModalBottomSheetSuccess) {
      final currentColor = (state as ModalBottomSheetSuccess).selectedColor;
      if (currentColor == selectedColor) {
        emit(
          ModalBottomSheetSuccess(
            selectedSize: (state as ModalBottomSheetSuccess).selectedSize,
            selectedColor: null,
          ),
        );
      } else {
        emit(
          ModalBottomSheetSuccess(
            selectedSize: (state as ModalBottomSheetSuccess).selectedSize,
            selectedColor: selectedColor,
          ),
        );
      }
    } else {
      emit(
        ModalBottomSheetSuccess(selectedSize: null, selectedColor: selectedColor),
      );
    }
  }
}
