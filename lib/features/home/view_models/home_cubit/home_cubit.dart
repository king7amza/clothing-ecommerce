import 'package:clothing_ecommerce/core/common/common_models/clothes_request_model.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:clothing_ecommerce/features/home/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final HomeServices _homeServices = HomeServices();
  Future<void> fetchMensShirt() async {
    emit(FetchingMensShirts());
    try {
      final requestModel = ClothesRequestModel(
        limit: 10,
        skip: 0,
        select: '',
      );
      final clothesData = await _homeServices.fetchMensShirt(
        requestModel,
      );
      emit(FetchedMensShirts(clothesData));
    } catch (e) {
      emit(MensShirtsError(e.toString()));
    }
  }
  Future<void> fetchWomensDresses() async {
    emit(FetchingWomensDresses());
    try {
      final requestModel = ClothesRequestModel(
        limit: 10,
        skip: 0,
        select: '',
      );
      final clothesData = await _homeServices.fetchWomensDresses(
        requestModel,
      );
      emit(FetchedWomensDresses(clothesData));
    } catch (e) {
      emit(WomensDressesError(e.toString()));
    }
  }
}
