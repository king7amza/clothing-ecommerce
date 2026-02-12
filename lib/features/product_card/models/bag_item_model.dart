import 'package:clothing_ecommerce/core/common/common_models/clothes_response_model.dart';

class BagItemModel {
  final Products product;
  final int quantity;
  final String selectedSize;
  final String selectedColor;
  const BagItemModel({
    required this.selectedSize,
    required this.selectedColor,
    required this.product,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  factory BagItemModel.fromMap(Map<String, dynamic> map) {
    return BagItemModel(
      product: Products.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      selectedSize: map['selectedSize'] as String,
      selectedColor: map['selectedColor'] as String,
    );
  }
}
