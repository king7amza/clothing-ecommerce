import 'package:clothing_ecommerce/features/auth/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final AuthServices _authServices = AuthServicesImpl();

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final bool isLoggedIn = await _authServices.loginWithEmailAndPassword(
      email,
      password,
    );
    final bool isEmailVerified = await _authServices.checkEmailVerification();
    try {
      if (isLoggedIn) {
        if (isEmailVerified) {
          emit(LoginSuccess());
        } else {
          await _authServices.sendEmailVerification();
          emit(EmailNotVerified("email is not verified"));
        }
      } else {
        emit(LoginError("this email is not registered"));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
