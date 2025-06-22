// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum MessageStatus { sending, sent, failed }

class MessageModel {
  final String? id;
  final String? content;
  final String? receiver;
  final String? sender;
  final DateTime? createdAt;
  final MessageStatus status;

  MessageModel({
    this.id,
    this.content,
    this.receiver,
    this.sender,
    this.createdAt,
    this.status = MessageStatus.sending,
  });

  MessageModel copyWith({
    String? id,
    String? content,
    String? receiver,
    String? sender,
    DateTime? createdAt,
    MessageStatus? status,
  }) {
    return MessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      receiver: receiver ?? this.receiver,
      sender: sender ?? this.sender,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'receiver': receiver,
      'sender': sender,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'status': status.name,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? map['id'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      receiver: map['receiver'] != null ? map['receiver'] as String : null,
      sender: map['sender'] != null ? map['sender'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      status: map['status'] != null
          ? MessageStatus.values.firstWhere(
              (e) => e.name == map['status'],
              orElse: () => MessageStatus.sending,
            )
          : MessageStatus.sending,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, content: $content, receiver: $receiver, sender: $sender, createdAt: $createdAt, status: $status)';
  }
}
