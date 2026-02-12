import 'dart:async';

import 'package:clothing_ecommerce/features/auth/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  Timer? _successTimer;
  VerifyEmailCubit() : super(VerifyEmailInitial());
  final AuthServices _authServices = AuthServicesImpl();

  Future<void> resendEmailVerification() async {
    emit(ResendEmailLoading());
    try {
      await _authServices.sendEmailVerification();
      emit(ResendEmailSuccess());
      _successTimer?.cancel();
      _successTimer = Timer(const Duration(seconds: 2), () {
        if (!isClosed) {
          emit(VerifyEmailInitial());
        }
      });
    } catch (e) {
      emit(ResendEmailError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _successTimer?.cancel();
    return super.close();
  }
}
