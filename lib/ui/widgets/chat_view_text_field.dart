import 'package:chat_app/core/services/chat_service_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatsTextField extends StatefulWidget {
  const ChatsTextField({super.key});

  @override
  State<ChatsTextField> createState() => _ChatsTextFieldState();
}

class _ChatsTextFieldState extends State<ChatsTextField> {
  @override
  Widget build(BuildContext context) {
    final message = Get.put(ChatServiceContoller());
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(),
              child: Icon(Icons.add),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TextField(
                controller: message.messageController,
                decoration: InputDecoration(
                  hint: Text('Write message....'),
                  suffixIcon: IconButton(
                    onPressed: () {
                      message.saveMessages();
                    },
                    icon: Icon(Icons.send),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.mic_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
