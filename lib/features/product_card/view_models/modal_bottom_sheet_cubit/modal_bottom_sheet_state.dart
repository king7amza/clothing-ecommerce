part of 'modal_bottom_sheet_cubit.dart';

sealed class ModalBottomSheetState {}

final class ModalBottomSheetInitial extends ModalBottomSheetState {}

final class ModalBottomSheetSuccess extends ModalBottomSheetState {
  final ProductColorsModel? selectedColor;
  final ProductSizesModel? selectedSize;
  ModalBottomSheetSuccess({this.selectedColor, this.selectedSize});
}
