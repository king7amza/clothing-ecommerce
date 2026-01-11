import 'package:clothing_ecommerce/core/common/common_services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final AuthServices _authServices = AuthServicesImpl();

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      await _authServices.registerWithEmailAndPassword(email, password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
