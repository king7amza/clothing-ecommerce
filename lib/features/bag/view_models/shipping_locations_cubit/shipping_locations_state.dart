part of 'shipping_locations_cubit.dart';

sealed class ShippingLocationsState {}

final class ShippingLocationInitial extends ShippingLocationsState {}

final class AddNewLocationLoading extends ShippingLocationsState {}

final class AddNewLocationSuccess extends ShippingLocationsState {}

final class AddNewLocationFailure extends ShippingLocationsState {
  final String errorMessage;

  AddNewLocationFailure(this.errorMessage);
}

final class FetchingShippingLocations extends ShippingLocationsState {}

final class ShippingLocationsFetched extends ShippingLocationsState {
  final List<ShippingLocationsModel> shippingLocations;

  ShippingLocationsFetched(this.shippingLocations);
}

final class ShippingLocationsError extends ShippingLocationsState {
  final String errorMessage;

  ShippingLocationsError(this.errorMessage);
}
