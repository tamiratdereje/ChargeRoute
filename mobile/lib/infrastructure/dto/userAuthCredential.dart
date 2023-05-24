import 'package:equatable/equatable.dart';

class UserAuthCredential extends Equatable {
  final String email;
  final String accessToken;
  final String userRole;

  const UserAuthCredential({
    required this.email,
    required this.accessToken,
    required this.userRole,
  });

  // from json to object
  factory UserAuthCredential.fromJson(Map<String, dynamic> json) {
    return UserAuthCredential(
      email: json['email'],
      accessToken: json['accessToken'],
      userRole: json['userRole'],
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'accessToken': accessToken,
      'userRole': userRole,
    };
  }

  @override
  List<Object?> get props => [email, accessToken, userRole];
}