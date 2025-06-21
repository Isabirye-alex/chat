// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class MessageModel {
 final int messageId;
  final String messageString;
  final String timeCreated;

  MessageModel({required this.messageId, required this.messageString, required this.timeCreated});
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'messageString': messageString,
      'timeCreated': timeCreated,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] as int,
      messageString: map['messageString'] as String,
      timeCreated: map['timeCreated'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageModel(messageId: $messageId, messageString: $messageString, timeCreated: $timeCreated)';
}
