part of 'auth_bloc.dart';

enum AuthStatus {  authenticated, unauthenticated }
abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends AuthenticationState {}

class Loading extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class Loaded extends AuthenticationState {
  final UserAuthCredential? userAuthCredential;
  final AuthStatus status;
  Loaded(this.status, { this.userAuthCredential});
}

class LoadedNoReturns extends AuthenticationState {
  final NoReturns noReturns;
  LoadedNoReturns({required this.noReturns});
}

class Error extends AuthenticationState {
  final String? message;
  Error({required this.message});
}
