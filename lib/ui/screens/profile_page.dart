import 'package:chat_app/core/services/auth_services/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () => Get.to(() => LoginScreen()),
        icon: Icon(Icons.logout),
      ),
    );
  }
}
