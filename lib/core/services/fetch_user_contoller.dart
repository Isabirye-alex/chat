import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FetchUserContoller extends GetxController {
  final db = AuthRepository();
  final currentUser = UserModel();

  List<UserModel> users = [];

  Future fetchUsers() async {
    try {
      final response = await db.fetchUsers(currentUser.uid!);

      if (response != null) {
        users = response.map((e) => UserModel.fromMap(e)).toList();
        update();
      }
    } catch (e) {
      debugPrint('Unkown error occured: $e');
      rethrow;
    }
  }
}
