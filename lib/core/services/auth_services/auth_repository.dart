import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signUp(String email, String password) async {
    final response = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return response;
  }

  Future logIn(String email, String password) async {
    final response = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return response;
  }

  Future resetPassword(String email) async {
    final response = await auth.sendPasswordResetEmail(email: email);
    return response;
  }

}
