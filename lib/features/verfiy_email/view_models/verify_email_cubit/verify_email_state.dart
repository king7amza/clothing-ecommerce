part of 'verify_email_cubit.dart';

sealed class VerifyEmailState {}

final class VerifyEmailInitial extends VerifyEmailState {}

final class ResendEmailLoading extends VerifyEmailState {}

final class ResendEmailSuccess extends VerifyEmailState {}

final class ResendEmailError extends VerifyEmailState {
  final String message;
  ResendEmailError(this.message);
}

final class CheckEmailVerificationSuccess extends VerifyEmailState {}

final class CheckEmailVerificationError extends VerifyEmailState {
  final String message;
  CheckEmailVerificationError(this.message);
}

final class CheckEmailVerificationLoading extends VerifyEmailState {}
