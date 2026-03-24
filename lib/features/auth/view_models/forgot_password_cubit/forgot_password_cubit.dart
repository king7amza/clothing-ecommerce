import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    emit(ForgotPasswordLoading());
    await _firebaseAuth.setLanguageCode("ar");
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = "something went wrong";
      if (e.code == 'invalid-email') {
        errorMessage = "invalid email";
      } else if (e.code == 'user-not-found') {
        errorMessage = "this email is not registered";
      } else if (e.code == 'too-many-requests') {
        errorMessage = "try again later";
      }
      emit(ForgotPasswordError(errorMessage));
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
