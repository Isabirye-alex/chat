import 'package:chat_app/core/services/chat_service_contoller.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:chat_app/ui/widgets/chat_bubble.dart';
import 'package:chat_app/ui/widgets/chat_view_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({
    super.key,
    required this.user,
    required this.receiver,
    required this.sender,
  });
  final UserModel user;
  final UserModel receiver;
  final UserModel sender;

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatServiceContoller());
    chatController.init(receiver, sender);
    return Scaffold(
      appBar: AppBar(
        primary: true,
        elevation: 10,
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
              ),
              margin: EdgeInsets.only(left: 15.w),
              padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.w),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            20.horizontalSpace,
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green,
                  child: Text(
                    '${user.firstName![0]} ${user.lastName![0]}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                10.horizontalSpace,
                Text(
                  '${user.firstName!} ${user.lastName!}',
                  style: const TextStyle(color: Color.fromARGB(255, 4, 24, 40)),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
              ),
              margin: EdgeInsets.only(right: 10.w),
              child: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: Column(
              children: [
                10.verticalSpace,
                Expanded(
                  child: Obx(() {
                    final messages = chatController.messages;
                    return ListView.separated(
                      reverse: true, // newest at bottom
                      itemCount: messages.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        final msg = messages[index];                      
                        final isCurrentUser = msg.sender == sender.uid;
                        return ChatBubble(
                          isCurrentUser: isCurrentUser,
                          message: msg,
                        );
                      },
                    );
                  }),
                ),
                50.verticalSpace,
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: ChatsTextField()),
        ],
      ),
    );
  }
}
