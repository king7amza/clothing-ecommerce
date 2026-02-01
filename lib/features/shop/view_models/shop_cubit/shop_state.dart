part of 'shop_cubit.dart';

sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class FetchingProducts extends ShopState {}

final class FetchedProducts extends ShopState {
  final Map<int, List<Products>> pageCache;
  int? totalProducts;
  FetchedProducts({required this.pageCache, required this.totalProducts});
}

final class ErrorFetchingProducts extends ShopState {
  final String errorMessage;
  ErrorFetchingProducts(this.errorMessage);
}
