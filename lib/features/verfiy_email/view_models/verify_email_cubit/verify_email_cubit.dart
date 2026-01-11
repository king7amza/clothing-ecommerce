import 'package:clothing_ecommerce/core/common/common_services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitial());
  final AuthServices _authServices = AuthServicesImpl();

  Future<void> resendEmailVerification() async {
    try {
      emit(ResendEmailLoading());
      await _authServices.sendEmailVerification();
      emit(ResendEmailSuccess());
    } catch (e) {
      emit(ResendEmailError(e.toString()));
    }
  }

  Future<void> checkEmailVerification() async {
    try {
      emit(CheckEmailVerificationLoading());
      final bool isEmailVerified = await _authServices.checkEmailVerification();
      if (isEmailVerified) {
        emit(CheckEmailVerificationSuccess());
      } else {
        emit(CheckEmailVerificationError("Email is not verified"));
      }
    } catch (e) {
      emit(CheckEmailVerificationError(e.toString()));
    }
  }
}
