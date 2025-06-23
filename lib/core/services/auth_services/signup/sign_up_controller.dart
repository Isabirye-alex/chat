import 'dart:io';

import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:chat_app/ui/screens/chats/chats_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final authRepository = AuthRepository();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isLoading = false.obs;
  late AuthRepository auth;
  final formKey = GlobalKey<FormState>();
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

  void validateAndSubmit(File? imageFile) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final isTaken = await authRepository.isUsernameTaken(
          usernameController.text.trim(),
        );
        if (isTaken) {
          Get.snackbar(
            'Error',
            'Username already taken. Please choose another one.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
          return;
        }

        final response = await authRepository.signUp(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // String? imageUrl = '';
        // if (imageFile != null) {
        //   imageUrl = await uploadImageToSupabase(imageFile, response.user!.uid);
        // }

        if (response != null) {
          UserModel user = UserModel(
            uid: response.user!.uid,
            lastName: lastNameController.text.trim(),
            firstName: firstNameController.text.trim(),
            userName: usernameController.text.trim(),
            email: emailController.text.trim(),
            imageUrl: '',
          );
          await authRepository.saveUser(user.toMap());
        }

        Get.snackbar('Success', 'Account created successfully.');
        Get.delete<SignUpController>();
        Get.offAll(() => ChatsScreen());
      } catch (e) {
        Get.snackbar(
          duration: Duration(seconds: 5),
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

  Future<String?> uploadImageToSupabase(File file, String userId) async {
    final supabase = Supabase.instance.client;
    final filePath =
        'avatars/$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';

    final fileBytes = await file.readAsBytes();

    final response = await supabase.storage
        .from('avatars')
        .uploadBinary(
          filePath,
          fileBytes,
          fileOptions: const FileOptions(contentType: 'image/jpeg'),
        );

    if (response.isEmpty) return null;

    final imageUrl = supabase.storage.from('avatars').getPublicUrl(filePath);
    return imageUrl;
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
