part of 'user_orders_cubit.dart';

sealed class UserOrdersState {}

final class UserOrdersInitial extends UserOrdersState {}

final class FetchingDeliveredOrders extends UserOrdersState {}

final class FetchedDeliveredOrders extends UserOrdersState {
  final List<UserOrdersModel> orders;
  FetchedDeliveredOrders(this.orders);
}

final class FetchingDeliveredOrdersError extends UserOrdersState {
  final String errorMessage;
  FetchingDeliveredOrdersError(this.errorMessage);
}

final class FetchingCancelledOrders extends UserOrdersState {}

final class FetchedCancelledOrders extends UserOrdersState {
  final List<UserOrdersModel> orders;
  FetchedCancelledOrders(this.orders);
}

final class FetchingCancelledOrdersError extends UserOrdersState {
  final String errorMessage;
  FetchingCancelledOrdersError(this.errorMessage);
}
