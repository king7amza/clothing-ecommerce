part of 'fetch_bag_products_cubit.dart';

sealed class FetchBagProductsState {}

final class FetchBagProductsInitial extends FetchBagProductsState {}

final class FetchingBagProducts extends FetchBagProductsState {}

final class FetchedBagProducts extends FetchBagProductsState {
  final List<BagItemModel> bagItems;
  FetchedBagProducts(this.bagItems);
}

final class BagProductsError extends FetchBagProductsState {
  final String message;
  BagProductsError(this.message);
}
