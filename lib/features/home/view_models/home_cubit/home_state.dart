part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FetchingMensShirts extends HomeState {}

final class FetchedMensShirts extends HomeState {
  final ClothesResponseModel clothesData;
  FetchedMensShirts(this.clothesData);
}

final class MensShirtsError extends HomeState {
  final String errorMessage;
  MensShirtsError(this.errorMessage);
}

final class FetchingWomensDresses extends HomeState {}

final class FetchedWomensDresses extends HomeState {
  final ClothesResponseModel clothesData;
  FetchedWomensDresses(this.clothesData);
}

final class WomensDressesError extends HomeState {
  final String errorMessage;
  WomensDressesError(this.errorMessage);
}
