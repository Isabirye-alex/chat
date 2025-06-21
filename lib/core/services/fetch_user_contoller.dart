import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/models/user_model/user_model.dart';

class FetchUserContoller extends GetxController {
  var currentUser = Rxn<UserModel>();
  final db = AuthRepository();

  List<UserModel> users = [];

  @override
  void onInit() {
    super.onInit();
    ever(currentUser, (user) {
      if (user != null) {
        fetchUsers(user.uid); // ✅ Correct usage
      }
    });
  }

  Future fetchUsers(String uid) async {
    try {
      final response = await db.fetchUsers(uid);
      if (response != null) {
        users = response.map((e) => UserModel.fromMap(e)).toList();
        update();
      }
    } catch (e) {
      debugPrint('Unknown error occurred: $e');
      rethrow;
    }
  }
}
