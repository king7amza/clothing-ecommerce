import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';

extension ProductExtensions on Products {
  bool get isNew {
    if (meta?.createdAt == null) return false;
    try {
      // final createdAt = DateTime.parse(meta!.createdAt!);
      // final now = DateTime.now();
      // return now.difference(createdAt).inDays < 7; // Check if the product is less than 7 days old
      return true; // For testing purposes, consider all products as new
    } catch (e) {
      return false;
    }
  }
}