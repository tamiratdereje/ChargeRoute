part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends AuthenticationState {}

class Loading extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserData? userData;
  Authenticated({ this.userData});
}

class AuthenticationLoading extends AuthenticationState {}

class UserAuthenticated extends Authenticated {
  UserAuthenticated({ UserData? userData}) : super(userData: userData);
}

class Unauthenticated extends AuthenticationState {}

class AdminAuthenticated extends Authenticated {
  AdminAuthenticated({ UserData? userData}) : super(userData: userData);
}

class ProviderAuthenticated extends Authenticated{
  ProviderAuthenticated({ UserData? userData}) : super(userData: userData);
}

class Loaded extends AuthenticationState {
  final UserAuthCredential? userAuthCredential;
  Loaded({ this.userAuthCredential});
}

class LoadedNoReturns extends AuthenticationState {
  final NoReturns noReturns;
  LoadedNoReturns({required this.noReturns});
}

class Error extends AuthenticationState {
  final String? message;
  Error({required this.message});
}
