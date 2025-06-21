
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, this.isCurrentUser = true,});
  final bool isCurrentUser;


  @override
  Widget build(BuildContext context) {
    final borderRadius = isCurrentUser
        ? BorderRadius.only(
            topLeft: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          )
        : BorderRadius.only(
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          );
    final alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Align(
      alignment: alignment,
      child: Container(
        alignment: alignment,
        margin: EdgeInsets.only(left: 10, right: 10),
        padding: EdgeInsets.all(10.w),
        constraints: BoxConstraints(maxWidth: 1.sw * 0.75, minWidth: 100.w),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green[400] : Colors.grey,
          borderRadius: borderRadius,
        ),
        child: Column(
          crossAxisAlignment: isCurrentUser
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Text(
              'Good evening, We are almost there. The app will be in air by tomorrow evening',
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.white,
              ),
            ),
            4.verticalSpace,
            Text(
              '08:50 PM',
              style: TextStyle(
                color: isCurrentUser ? Colors.black : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
