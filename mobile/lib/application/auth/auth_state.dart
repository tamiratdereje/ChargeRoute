part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateAuthenticated extends AuthenticationState {
  final UserData? userData;

  AuthenticationStateAuthenticated({this.userData});
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationStateUnauthenticated extends AuthenticationState {}

class AuthenticationStateUserAuthenticated
    extends AuthenticationStateAuthenticated {
  AuthenticationStateUserAuthenticated({UserData? userData})
      : super(userData: userData);
}

class AuthenticationStateAdminAuthenticated
    extends AuthenticationStateAuthenticated {
  AuthenticationStateAdminAuthenticated({UserData? userData})
      : super(userData: userData);
}

class AuthenticationStateProviderAuthenticated
    extends AuthenticationStateAuthenticated {
  AuthenticationStateProviderAuthenticated({UserData? userData})
      : super(userData: userData);
}

class AuthenticationStateLoadedNoReturns extends AuthenticationState {
  final NoReturns noReturns;

  AuthenticationStateLoadedNoReturns({required this.noReturns});
}

class AuthenticationStateError extends AuthenticationState {
  final String? message;

  AuthenticationStateError({required this.message});
}
