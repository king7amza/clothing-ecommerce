import 'package:clothing_ecommerce/features/bag/models/shipping_locations_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shipping_locations_state.dart';

class ShippingLocationsCubit extends Cubit<ShippingLocationsState> {
  ShippingLocationsCubit() : super(ShippingLocationInitial());

  void addNewLocation(String currentAddress) async {
    emit(AddNewLocationLoading());
    try {
      // Simulate a delay for adding the location
      await Future.delayed(const Duration(seconds: 2), () {
        // emit(AddNewLocationSuccess(currentAddress));
        debugPrint("New location added: $currentAddress");
        shippingLocations.add(
          ShippingLocationsModel(
            id: DateTime.now().toString(),
            address: currentAddress,
          ),
        );
        emit(AddNewLocationSuccess());
      });
    } catch (e) {
      emit(AddNewLocationFailure(e.toString()));
    }
  }

  void fetchShippingLocations() async {
    // Simulate fetching shipping locations from a data source
    emit(FetchingShippingLocations());
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        emit(ShippingLocationsFetched(shippingLocations));
      });
    } catch (e) {
      emit(ShippingLocationsError(e.toString()));
    }
  }
}
