import 'package:chat_app/core/services/auth_services/login/login_screen.dart';
import 'package:chat_app/ui/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          } else {
            return ChatsScreen();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
