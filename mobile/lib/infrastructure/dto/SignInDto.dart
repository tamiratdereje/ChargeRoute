


import '../../domain/auth/models/signInFormForm.dart';

class SignInDto{
  final String email;
  final String password;
  SignInDto({
    required this.email,
    required this.password,
  });
  // to json
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };

  static SignInDto fromForm(SignInForm signInForm) {
    return SignInDto(
      email: signInForm.email,
      password: signInForm.password,
    );
  }
}