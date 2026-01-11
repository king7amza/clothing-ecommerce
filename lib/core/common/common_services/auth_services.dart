import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<void> registerWithEmailAndPassword(String email, String password);
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<void> sendEmailVerification();
  Future<bool> checkEmailVerification();
}

class AuthServicesImpl extends AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    final User user = userCredential.user!;
    await user.sendEmailVerification();
  }

  @override
  Future<void> sendEmailVerification() async {
    final User user = _firebaseAuth.currentUser!;
    await user.sendEmailVerification();
  }

  @override
  Future<bool> checkEmailVerification() async {
    final User user = _firebaseAuth.currentUser!;
    await user.reload();
    return user.emailVerified;
  }

  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;
    return user != null;
  }
}
