part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class AddNewCardInitial extends PaymentMethodsState {}

final class AddNewCardLoading extends PaymentMethodsState {}

final class AddNewCardSuccess extends PaymentMethodsState {}

final class AddNewCardFailure extends PaymentMethodsState {
  final String errorMessage;
  AddNewCardFailure(this.errorMessage);
}

final class FetchCardsLoading extends PaymentMethodsState {}

final class FetchCardsSuccess extends PaymentMethodsState {
  final List<PaymentCardsModel> paymentMethods;
  FetchCardsSuccess(this.paymentMethods);
}

final class FetchCardsFailure extends PaymentMethodsState {
  final String errorMessage;
  FetchCardsFailure(this.errorMessage);
}
