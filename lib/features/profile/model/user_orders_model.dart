// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clothing_ecommerce/features/bag/models/delivery_methods_model.dart';
import 'package:clothing_ecommerce/features/bag/models/payment_cards_model.dart';
import 'package:clothing_ecommerce/features/bag/models/shipping_locations_model.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';

class UserOrdersModel {
  final String orderId;
  final String orderDate;
  final String orderStatus;
  final int orderDeliveringTime;
  final List<BagItemModel> bagItems;
  final ShippingLocationsModel? shippingLocation;
  final PaymentCardsModel? paymentMethod;
  final DeliveryMethodsModel deliveryMethod;
  final double totalAmount;
  final int totalQuantity;

  const UserOrdersModel({
    required this.orderId,
    required this.orderDate,
    required this.orderStatus,
    required this.orderDeliveringTime,
    required this.bagItems,
    // required this.shippingLocation,
    this.shippingLocation,
    // required this.paymentMethod,
    this.paymentMethod,
    required this.deliveryMethod,
    required this.totalAmount,
    required this.totalQuantity,
  });

  UserOrdersModel copyWith({
    String? orderId,
    String? orderDate,
    String? orderStatus,
    int? orderDeliveringTime,
    List<BagItemModel>? bagItems,
    ShippingLocationsModel? shippingLocation,
    PaymentCardsModel? paymentMethod,
    DeliveryMethodsModel? deliveryMethod,
    double? totalAmount,
    int? totalQuantity,
  }) {
    return UserOrdersModel(
      orderId: orderId ?? this.orderId,
      orderDate: orderDate ?? this.orderDate,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDeliveringTime: orderDeliveringTime ?? this.orderDeliveringTime,
      bagItems: bagItems ?? this.bagItems,
      shippingLocation: shippingLocation ?? this.shippingLocation,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }
}

List<UserOrdersModel> userOrdersLogs = [];
