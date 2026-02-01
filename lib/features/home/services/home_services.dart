import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_request_model.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:dio/dio.dart';

class HomeServices {
  final aDio = Dio();
  Future<ClothesResponseModel> fetchMensShirt(
    ClothesRequestModel requestModel,
  ) async {
    try {
      aDio.options.baseUrl = AppConstants.apiBaseUrl;
      final response = await aDio.get(
        "${AppConstants.productsEndpoint}${AppConstants.mensShirtCategoryEndpoint}",
        queryParameters: requestModel.toMap(),
      );
      if (response.statusCode == 200) {
        return ClothesResponseModel.fromMap(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<ClothesResponseModel> fetchWomensDresses(
    ClothesRequestModel requestModel,
  ) async {
    try {
      aDio.options.baseUrl = AppConstants.apiBaseUrl;
      final response = await aDio.get(
        "${AppConstants.productsEndpoint}${AppConstants.womensDressesCategoryEndpoint}",
        queryParameters: requestModel.toMap(),
      );
      if (response.statusCode == 200) {
        return ClothesResponseModel.fromMap(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
