import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FetchUserController extends GetxController {
  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final AuthRepository db = AuthRepository();
  List<UserModel> filteredUsers = <UserModel>[].obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce<String>(
      searchText,(val) => search(val),
      time: Duration(milliseconds: 300),
    );
  
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser != null) {
        try {
          final userData = await db.loadUser(firebaseUser.uid);
          if (userData != null) {
            currentUser.value = UserModel.fromMap(userData);
            await _listenToUsers(firebaseUser.uid);
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

  void search(String text) {
    if (text.trim().isEmpty) {
      filteredUsers.clear();
    } else {
      filteredUsers.assignAll(
        users.where(
          (e) =>
              (e.firstName ?? '').toLowerCase().contains(text.toLowerCase()) ||
              (e.lastName ?? '').toLowerCase().contains(text.toLowerCase()),
        ),
      );
    }
  }

 _listenToUsers(String currentUserId) {
    isLoading.value = true;
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen(
          (snapshot) {
            final updatedUsers = snapshot.docs
                .where((doc) => doc.id != currentUserId) 
                .map((doc) => UserModel.fromMap(doc.data()))
                .toList();
            users.assignAll(updatedUsers);
            isLoading.value = false;
          },
          onError: (e) {
            error.value = 'Failed to load users: $e';
            isLoading.value = false;
          },
        );
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
