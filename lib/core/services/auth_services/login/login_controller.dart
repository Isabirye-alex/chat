import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/ui/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void validateAndSubmit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        // Step 1: Log in
        await authRepository.logIn(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // Step 2: Fetch user details from Firestore
        final user = await authRepository.getCurrentUserDetails();

        if (user == null) {
          Get.snackbar(
            'Error',
            'No user data found in Firestore.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return;
        }
        // Optional: You can store `user` globally using a GetX controller or some other state management

        Get.snackbar('Success', 'Logged in as ${user.firstName}');
        // Get.delete<LoginController>();
        Get.delete<LoginController>();
        Get.offAll(() => ChatsScreen());
      } catch (e) {
        Get.snackbar(
          'Login Failed',
          '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Please fix the form errors');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
