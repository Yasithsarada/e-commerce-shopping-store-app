// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String? googleId;
  final String? imageUrl;
  final String username;
  final String email;
  final String? password;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.password,
    required this.token,
    this.googleId,
     this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'token': token,
      'googleId': googleId,
      'imageUrl' : imageUrl
    };
  }late

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String?,
      token: map['token'] as String,
      // googleId: map['googleId'] as String ?? "",
      // imageUrl: map['imageUrl'] as String ?? "",
      googleId: map['googleId'] as String?,
      imageUrl: map['imageUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
