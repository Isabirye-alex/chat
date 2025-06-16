import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:chat_app/ui/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final authRepository = AuthRepository();
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;
  final db = FirebaseFirestore.instance;

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

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void validateAndSubmit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final response = await authRepository.signUp(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
          if(response != null){
          UserModel user = UserModel(
            uid:response.uid, 
            lastName: lastNameController.text.trim(),
             firstName: firstNameController.text.trim(),
              userName: usernameController.text.trim(), 
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
               );
          }
        
        Get.snackbar('Success', 'Account created successfully.');
        Get.to(() => ChatsScreen());
      } catch (e) {
        Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.blue,

          'Error',
          'Failed to create account: $e',
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Please fix the errors in the form');
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
