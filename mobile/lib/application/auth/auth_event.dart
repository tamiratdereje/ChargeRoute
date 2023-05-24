part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoginEvent extends AuthenticationEvent {
  final SignInForm signInForm;
  LoginEvent({required this.signInForm});
}
class SignUpEvent extends AuthenticationEvent {
  final SignUpForm signUpForm;
  SignUpEvent({required this.signUpForm});
}
class DeleteAccountEvent extends AuthenticationEvent {}
class LogoutEvent extends AuthenticationEvent {}
class GetUserAuthCredentialEvent extends AuthenticationEvent {}
class ForgotPasswordEvent extends AuthenticationEvent {
  final String email;
  ForgotPasswordEvent({required this.email});
}


