import 'dart:async';
import 'package:chat_app/models/message_model/message_model.dart';
import 'package:chat_app/utilis/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ChatBubble extends StatefulWidget {
  const ChatBubble({
    super.key,
    this.isCurrentUser = true,
    required this.message,
  });

  final bool isCurrentUser;
  final MessageModel message;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final message = MessageModel();

  final Rx<DateTime> _now = DateTime.now().obs;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 10), (_) {
      _now.value = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    late String text = '';
    if (widget.message.content!.isNotEmpty) {
      text = widget.message.content!;
    }
    final borderRadius = widget.isCurrentUser
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

    final alignment = widget.isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    Widget statusIcon() {
      switch (widget.message.status) {
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
          return Icon(Icons.error, size: 16.w, color: Colors.redAccent);
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
          color: widget.isCurrentUser ? Colors.green[400] : Colors.grey,
          borderRadius: borderRadius,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 1.sw * 0.2,
            maxWidth: 1.sw * 0.75,
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: widget.isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.end,
              children: [
                Text(text, style: TextStyle(color: Colors.white)),
                4.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => Text(
                        formatTimestamp(widget.message.createdAt!, _now.value),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),

                    SizedBox(width: 6.w),
                    if (widget.isCurrentUser) statusIcon(),
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
