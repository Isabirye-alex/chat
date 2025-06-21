import 'package:chat_app/core/services/chat_service.dart';
import 'package:chat_app/models/message_model/message_model.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceContoller extends GetxController {
  final chatService = ChatService();
  final messageController = TextEditingController();

  late UserModel receiver;
  late UserModel sender;
  late String chatRoomId;

  final RxList<MessageModel> messages = <MessageModel>[].obs;

  void init(UserModel receiverUser, UserModel senderUser) {
    receiver = receiverUser;
    sender = senderUser;
    chatRoomId = _generateChatRoomId(sender.uid!, receiver.uid!);

    _listenToMessages();
  }

  String _generateChatRoomId(String uid1, String uid2) {
    return uid1.compareTo(uid2) > 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
  }

  void _listenToMessages() {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('createdAt', descending: false) // latest at top
        .snapshots()
        .listen((snapshot) {
          messages.value = snapshot.docs
              .map((doc) {
                final data = doc.data();
                return MessageModel.fromMap(data);
              })
              .toList()
              .reversed
              .toList(); // reverse to show oldest first
        });
  }

  Future<void> saveMessages() async {
    if (chatRoomId.isEmpty) throw Exception('chatRoomId is empty');

    final now = DateTime.now();
    final message = MessageModel(
      id: now.microsecondsSinceEpoch.toString(),
      createdAt: now,
      receiver: receiver.uid,
      sender: sender.uid,
      content: messageController.text.trim(),
    );

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());

    messageController.clear();
  }
}
