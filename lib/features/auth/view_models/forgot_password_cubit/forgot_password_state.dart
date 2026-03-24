part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSuccess extends ForgotPasswordState {}

final class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
}
