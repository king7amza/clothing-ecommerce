import 'package:clothing_ecommerce/features/profile/model/orders_states_model.dart';
import 'package:clothing_ecommerce/features/profile/model/user_orders_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_orders_state.dart';

class UserOrdersCubit extends Cubit<UserOrdersState> {
  UserOrdersCubit() : super(UserOrdersInitial());

  void moveToExactState(String orderState, UserOrdersModel order) {
    order = order.copyWith(orderStatus: orderState);
    if (order.orderStatus == "Delivered") {
      deliveredOrders.add(order);
    } else if (order.orderStatus == "Cancelled") {
      cancelledOrders.add(order);
    }
  }

  Future<void> fetchDeliveredOrders() async {
    emit(FetchingDeliveredOrders());
    try {
      Future.delayed(Duration(seconds: 1), () {
        emit(FetchedDeliveredOrders(deliveredOrders));
      });
    } catch (e) {
      emit(FetchingDeliveredOrdersError(e.toString()));
    }
  }

  Future<void> fetchCancelledOrders() async {
    emit(FetchingCancelledOrders());
    try {
      Future.delayed(Duration(seconds: 1), () {
        emit(FetchedCancelledOrders(cancelledOrders));
      });
    } catch (e) {
      emit(FetchingCancelledOrdersError(e.toString()));
    }
  }
}
