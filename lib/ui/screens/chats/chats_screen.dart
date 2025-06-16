import 'package:chat_app/core/services/auth_services/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Chats(),
    );
  }
}

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.all(8.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            35.verticalSpace,
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Text('Image'),
                ),
                Text('Username')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
