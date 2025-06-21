// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String? id;
  final String? content;
  final String? receiver;
  final String? sender;
  final DateTime? createdAt;

  MessageModel({
    this.id,
    this.content,
    this.createdAt,
    this.receiver,
    this.sender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'receiver': receiver,
      'sender': sender,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? map['id'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      receiver: map['receiver'] != null ? map['receiver'] as String : null,
      sender: map['sender'] != null ? map['sender'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, content: $content, receiver: $receiver, sender: $sender, createdAt: $createdAt)';
  }
}
