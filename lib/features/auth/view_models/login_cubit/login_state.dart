part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

final class EmailNotVerified extends LoginState {
  final String message;
  EmailNotVerified(this.message);
}
