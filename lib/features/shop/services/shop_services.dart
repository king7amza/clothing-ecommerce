import 'package:clothing_ecommerce/core/app_constants.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_request_model.dart';
import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';
import 'package:dio/dio.dart';

class ShopServices {
  final aDio = Dio();
  Future<ClothesResponseModel?> fetchProducts(
    ClothesRequestModel requestModel,
  ) async {
    aDio.options.baseUrl = AppConstants.apiBaseUrl;
    final response = await aDio.get(
      AppConstants.productsEndpoint,
      queryParameters: requestModel.toMap(),
    );
    if (response.statusCode == 200 && response.data != null) {
      return ClothesResponseModel.fromMap(response.data);
    } else {
      return null;
    }
  }
}
