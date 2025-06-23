import 'package:chat_app/core/others/wrapper/wrapper.dart';
import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  static LogoutController get instance => Get.find();
  final AuthRepository _authRepo = AuthRepository();

  final RxBool isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authRepo.logOut();
      Get.to(() => Wrapper());
      debugPrint('Logout completed');
    } catch (e) {
      Get.snackbar('Logout Failed', e.toString());
      debugPrint('Logout error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
