// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// A model class representing a user in the chat application.
///
/// Contains user-related information such as identifiers, display name,
/// profile picture, and other relevant user data.
///
///
class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? userName;
  final String uid;
  final String? imageUrl;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.userName,
    required this.uid,
    this.imageUrl
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'userName': userName,
      'uid': uid,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      uid: map['uid'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
