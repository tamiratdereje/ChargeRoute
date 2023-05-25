import '../../domain/auth/models/signUpForm.dart';

class SignUpDto{
  final String name;
  final String email;
  final String password;
  SignUpDto({
    required this.name,
    required this.email,
    required this.password,
  });
  // to json
  Map<String, String> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };

  static SignUpDto fromForm(SignUpForm signUpForm) {
    return SignUpDto(
      name: signUpForm.name,
      email: signUpForm.email,
      password: signUpForm.password,
    );
  }
}