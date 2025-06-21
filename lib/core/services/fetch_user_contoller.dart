import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FetchUserController extends GetxController {
  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  final AuthRepository db = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    // Listen to Firebase auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        try {
          // Fetch current user data using AuthRepository
          final userData = await db.loadUser(firebaseUser.uid);
          if (userData != null) {
            currentUser.value = UserModel.fromMap(userData);
            await fetchUsers(firebaseUser.uid); // Fetch users immediately
          } else {
            error.value = 'Current user data not found';
            isLoading.value = false;
          }
        } catch (e) {
          debugPrint('Error fetching current user: $e');
          error.value = 'Failed to load user: $e';
          isLoading.value = false;
        }
      } else {
        currentUser.value = null;
        users.clear();
        isLoading.value = false;
        error.value = 'No user signed in';
      }
    });
  }

  Future fetchUsers(String uid) async {
    try {
      isLoading.value = true;
      error.value = '';
      final response = await db.fetchUsers(uid);
      if (response != null && response.isNotEmpty) {
        users.assignAll(response.map((e) => UserModel.fromMap(e)).toList());
      } else {
        users.clear();
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint('Error fetching users: $e');
      error.value = 'Failed to fetch users: $e';
      isLoading.value = false;
      rethrow;
    }
  }
}
