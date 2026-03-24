part of 'submit_order_cubit.dart';

sealed class SubmitOrderState {}

final class SubmitOrderInitial extends SubmitOrderState {}

final class AddingOrderToLogs extends SubmitOrderState {}

final class AddOrderToLogsSuccess extends SubmitOrderState {}

final class AddOrderToLogsError extends SubmitOrderState {
  final String error;
  AddOrderToLogsError(this.error);
}
