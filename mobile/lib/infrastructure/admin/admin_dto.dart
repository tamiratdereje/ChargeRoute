import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class AdminModel extends Equatable {
  String? id;
  final String name;
  final String email;
  final String role;
  String? password;
  

  AdminModel({
    this.id,
    required this.name,
    required this.email,
    required this.role,
    this.password
  });



  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? '',
      name: json['name'],
      email: json['email'],
      role: json['role'],
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'name': name,
      'email': email,
      'role': role,
      'password': password ?? '',
    };
  }
  
  @override
  List<Object?> get props => [id, name, email, role];
}
