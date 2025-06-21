import 'package:chat_app/core/services/auth_services/logout.dart';
import 'package:chat_app/ui/screens/account_settings.dart';
import 'package:chat_app/ui/screens/chats/chat_tile.dart';
import 'package:chat_app/ui/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int selectedIndex = 0;
   List<Widget> pages = [
    ChatTile(),
    ProfilePage(),
    AccountSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Bottom navigation bar to hold navigation icons and handle navigation to different ui screens
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow:[ BoxShadow(spreadRadius: 0, blurRadius: 10, color: Colors.black38)]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            onTap:(value){
              selectedIndex = value;
              setState(() {
                
              });
            },
            currentIndex: selectedIndex,
          
            items: [
              BottomNavigationBarItem(icon: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Icon(Icons.message),
              ),
              label: ''
            ),
              BottomNavigationBarItem(icon: Padding(
                padding: EdgeInsets.only(top:10.h),
                child: Icon(Icons.message),
              ),
              label: ''
              ),
              BottomNavigationBarItem(icon: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Icon(Icons.message),
              ),
              label: ''
              )
            ],
          ),
        ),
      ),
      
      //Body to display the selected page on the bottom navigation menu
      body: pages[selectedIndex],
    );
  }
}



