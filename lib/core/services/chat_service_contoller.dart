import 'package:chat_app/models/message_model/message_model.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatServiceContoller extends GetxController {
  final messageController = TextEditingController();

  late UserModel receiver;
  late UserModel sender;
  late String chatRoomId;
  late Map<String, dynamic> isPedning;

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
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen((snapshot) {
          messages.value = snapshot.docs
              .map(_getStatusFromDoc)
              .toList()
              .reversed
              .toList();
        });
  }



  MessageModel _getStatusFromDoc(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final status = doc.metadata.hasPendingWrites
        ? MessageStatus.sending
        : MessageStatus.sent;

    return MessageModel.fromMap(data).copyWith(status: status);
  }

  Future<void> saveMessages() async {
    if (chatRoomId.isEmpty) throw Exception('chatRoomId is empty');

    final msg = messageController.text.trim();

    if (msg.isEmpty) {
      Get.snackbar(
        'Text field empty',
        'Please enter a message before sending.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return; // prevent sending
    }

    final now = DateTime.now();
    final message = MessageModel(
      id: now.microsecondsSinceEpoch.toString(),
      createdAt: now,
      receiver: receiver.uid,
      sender: sender.uid,
      content: msg,
      status: MessageStatus.sending,
    );

    messages.insert(0, message);
    messageController.clear();

    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .doc(message.id)
          .set(message.copyWith(status: MessageStatus.sent).toMap());

      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        messages[index] = messages[index].copyWith(status: MessageStatus.sent);
      }

      await getLastMessage(
        receiver.uid!,
        sender.uid!,
        message.content!,
        now.microsecondsSinceEpoch,
      );
    } catch (e) {
      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != 0) {
        messages[index] = messages[index].copyWith(
          status: MessageStatus.failed,
        );
      }
      debugPrint('Message sending failed: $e');
    }
  }

  getLastMessage(
    String receiverUid,
    String currentUid,
    String message,
    int timeStamp,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .update({
            'lastMessage': {
              'content': message,
              'timeStamp': timeStamp,
              'senderId': currentUid,
            },
          });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverUid)
          .update({
            'lastMessage': {
              'content': message,
              'timeStamp': timeStamp,
              'senderId': currentUid,
            },
          });
    } catch (e) {
      rethrow;
    }
  }
}
