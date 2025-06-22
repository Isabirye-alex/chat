// ignore_for_file: unreachable_switch_default

import 'package:chat_app/models/message_model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    this.isCurrentUser = true,
    required this.message,
  });

  final bool isCurrentUser;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    late String text = '';
    if (message.content!.isNotEmpty) {
      text = message.content!;
    } else {
      text =
          'Good evening. It has been a really productive project. Can\'t wait to get onto other projects ';
    }

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

    final formattedDate = DateFormat('MMM d, y').format(message.createdAt!);
    final formattedTime = DateFormat('hh:mm a').format(message.createdAt!);
    final fullDateTime = '$formattedDate ($formattedTime)';

    Widget statusIcon() {
      switch (message.status) {
        case MessageStatus.sending:
          return SizedBox(
            width: 14.w,
            height: 14.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              color: Colors.grey.shade300,
            ),
          );
        case MessageStatus.sent:
          return Icon(Icons.check, size: 16.w, color: Colors.greenAccent);
        case MessageStatus.failed:
          return Tooltip(
            message: 'Failed to send',
            child: Icon(
              Icons.warning_amber_rounded,
              size: 16.w,
              color: Colors.redAccent,
            ),
          );
        default:
          return const SizedBox.shrink();
      }
    }

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green[400] : Colors.grey,
          borderRadius: borderRadius,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 1.sw * 0.2,
            maxWidth: 1.sw * 0.75,
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.end,
              children: [
                Text(text, style: TextStyle(color: Colors.white)),
                4.verticalSpace,
                                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      fullDateTime,
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    ),
                    SizedBox(width: 6.w),
                    if (isCurrentUser) statusIcon(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
