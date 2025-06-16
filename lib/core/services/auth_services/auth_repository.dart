import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final db = FirebaseFirestore.instance;
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

  Future saveUser(Map<String, dynamic> userData) async {
    await db.collection('users').doc(userData['uid']).set(userData);
  }

  Future<Map<String, dynamic>?> loadUser(String uid) async {
    try {
      final response = await db.collection('users').doc(uid).get();

      if (response.data() != null) {
        return response.data();
      }
    } catch (e) {
      throw Exception('Error! User Data could not be loaded');
    }
    return null;
  }
}
