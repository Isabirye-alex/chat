import 'package:chat_app/models/user_model/user_model.dart';
import 'package:chat_app/ui/widgets/chat_bubble.dart';
import 'package:chat_app/ui/widgets/chat_view_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6.r),
              ),
              margin: EdgeInsets.only(left: 15.w),
              padding: EdgeInsets.all(2.w),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back),
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
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                10.horizontalSpace,
                Text(
                  '${user.firstName!} ${user.lastName!}',
                  style: TextStyle(color: const Color.fromARGB(255, 4, 24, 40)),
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6.r),
              ),
              margin: EdgeInsets.only(right: 10.w),
              child: Icon(Icons.more_vert),
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
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ChatBubble(isCurrentUser: false);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 5);
                    },
                    itemCount: 50,
                  ),
                ),
                50.verticalSpace,
              ],
            ),
          ),
          // 40.verticalSpace,
          Positioned(bottom: 0, left: 0, right: 0, child: ChatsTextField()),
        ],
      ),
    );
  }
}
