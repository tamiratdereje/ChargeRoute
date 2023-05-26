import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserAuthCredential extends Equatable{
  String id;
  String name;
  String email;
  String role;
  String password;
  String createdAt;
  @override
  List<Object?> get props => [id, name, email, password, role, createdAt];

  UserAuthCredential({ 
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.password,
    required this.createdAt,
  });
  // to json
  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'role': role,
    'password': password,
    'createdAt': createdAt,
  };

  factory UserAuthCredential.fromJson(Map<String, dynamic> json) {
    return UserAuthCredential(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      password: json["password"],
      createdAt: json["createdAt"],
    );
  }
}

class UserData extends Equatable{
  UserAuthCredential user;
  String token;
  @override
  List<Object?> get props => [user, token];
  UserData({required this.user, required this.token});

  Map<String, dynamic> toJson() => {
    'data': user.toJson(),
    'token': token,
  };
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: UserAuthCredential.fromJson(json["data"]),
      token: json["token"],
    );
  }
}
