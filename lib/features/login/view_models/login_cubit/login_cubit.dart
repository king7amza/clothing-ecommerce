import 'package:clothing_ecommerce/core/common/common_services/auth_services.dart';
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
    emit(LoginLoading());
    try {
      if (isLoggedIn) {
        emit(LoginSuccess());
      } else {
        emit(LoginError("this email is not registered"));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
