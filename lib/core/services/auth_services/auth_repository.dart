import 'package:chat_app/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> logOut() async {
    try {
      await auth.signOut();
      debugPrint('User signed out successfully');
    } catch (e) {
      debugPrint('Error during sign-out: $e');
      rethrow; // Rethrow to allow the caller to handle the error
    }
  }

  Future resetPassword(String email) async {
    final response = await auth.sendPasswordResetEmail(email: email);
    return response;
  }

  Future<bool> isUsernameTaken(String username) async {
    final query = await db
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }

  Future<String?> getEmailByUsername(String username) async {
    try {
      final querySnapshot = await db
          .collection('users')
          .where('userName', isEqualTo: username)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        return userData['email'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching email by username: $e');
    }
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

  Future<List<Map<String, dynamic>>?> fetchUsers(String currentUserId) async {
    try {
      final response = await db
          .collection('users')
          .where('uid', isNotEqualTo: currentUserId)
          .get();

      return response.docs.map((e) => e.data()).toList();
    } catch (e) {
      debugPrint('Error fetching users from the database');
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUserDetails() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }
}
