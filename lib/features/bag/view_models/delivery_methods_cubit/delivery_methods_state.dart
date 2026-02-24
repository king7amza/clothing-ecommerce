part of 'delivery_methods_cubit.dart';

sealed class DeliveryMethodsState {}

final class DeliveryMethodsInitial extends DeliveryMethodsState {}

final class ToggleDeliveryMethod extends DeliveryMethodsState {
  final String? deliveryMethodName;
  ToggleDeliveryMethod(this.deliveryMethodName);
}
