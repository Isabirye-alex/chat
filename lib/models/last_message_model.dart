// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LastMessageModel {
  final String content;
  final int timeStamp;
  final String senderId;

  LastMessageModel({
    required this.content,
    required this.timeStamp,
    required this.senderId,
  });

  factory LastMessageModel.fromMap(Map<String, dynamic> map) {
    return LastMessageModel(
      content: map['content'] as String,
      timeStamp: map['timeStamp'] as int,
      senderId: map['senderId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'timeStamp': timeStamp,
      'senderId': senderId,
    };
  }

  String toJson() => json.encode(toMap());

  factory LastMessageModel.fromJson(String source) => LastMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LastMessageModel(content: $content, timeStamp: $timeStamp, senderId: $senderId)';
}
