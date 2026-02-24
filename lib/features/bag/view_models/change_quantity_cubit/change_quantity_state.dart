part of 'change_quantity_cubit.dart';

sealed class ChangeQuantityState {}

final class ChangeQuantityInitial extends ChangeQuantityState {}

final class IncrementQuantityLoading extends ChangeQuantityState {}

final class IncrementQuantitySuccess extends ChangeQuantityState {
  final BagItemModel bagItem;
  IncrementQuantitySuccess(this.bagItem);
}

final class IncrementQuantityError extends ChangeQuantityState {
  final String message;
  IncrementQuantityError(this.message);
}

final class DecrementQuantityLoading extends ChangeQuantityState {}

final class DecrementQuantitySuccess extends ChangeQuantityState {
  final BagItemModel bagItem;
  DecrementQuantitySuccess(this.bagItem);
}

final class DecrementQuantityError extends ChangeQuantityState {
  final String message;
  DecrementQuantityError(this.message);
}
