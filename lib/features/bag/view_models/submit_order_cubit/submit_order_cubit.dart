import 'dart:math';

import 'package:clothing_ecommerce/features/bag/models/delivery_methods_model.dart';
import 'package:clothing_ecommerce/features/product_card/models/bag_item_model.dart';
import 'package:clothing_ecommerce/features/profile/model/user_orders_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'submit_order_state.dart';

class SubmitOrderCubit extends Cubit<SubmitOrderState> {
  SubmitOrderCubit() : super(SubmitOrderInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void addOrderToLogs({
    required List<BagItemModel> bagItemModel,
    // required ShippingLocationsModel shippingLocationsModel,
    // required PaymentCardsModel paymentMethodsModel,
    required DeliveryMethodsModel deliveryMethodsModel,
    required double totalAmount,
    required int totalQuantity,
  }) {
    emit(AddingOrderToLogs());
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      final DateTime dateNow = DateTime.now();
      final formatDate = DateFormat('yyyy-MM-dd').format(dateNow);
      final random = Random();
      final int orderDeliveringTime = 30 + random.nextInt(31);
      userOrdersLogs.add(
        UserOrdersModel(
          orderId: userId,
          orderDate: formatDate,
          orderStatus: "Delivering",
          orderDeliveringTime: orderDeliveringTime,
          bagItems: bagItemModel,
          // shippingLocation: shippingLocationsModel,
          // paymentMethod: paymentMethodsModel,
          deliveryMethod: deliveryMethodsModel,
          totalAmount: totalAmount,
          totalQuantity: totalQuantity,
        ),
      );
      emit(AddOrderToLogsSuccess());
    } catch (e) {
      emit(AddOrderToLogsError(e.toString()));
    }
  }
}
