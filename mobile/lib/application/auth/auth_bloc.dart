import 'dart:io';

import 'package:charge_station_finder/domain/auth/models/signInFormForm.dart';
import 'package:charge_station_finder/infrastructure/repository/authRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/auth/models/noReturn.dart';
import '../../domain/auth/models/signUpForm.dart';
import '../../infrastructure/dto/userAuthCredential.dart';
import '../../domain/contracts/IAuthRepository.dart';
import '../core/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository authRepository;

  AuthenticationBloc({required this.authRepository}) : super(Empty()) {
    on<SignUpEvent>(_onSignUp);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<GetUserAuthCredentialEvent>(_onGetUser);
  }

  AuthenticationState get initialState => Empty();

  void _onLogin(LoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final failureOrAuthCredential = await authRepository.login(
      signInForm: event.signInForm,
    );
    debugPrint(failureOrAuthCredential.toString());
    emit(_eitherLoginOrError(failureOrAuthCredential));
    // emit(Authenticated());
  }

  void _onDeleteAccount(
      DeleteAccountEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final failureOrNoReturns = await authRepository.deleteAccount();
    emit(_eitherNoReturnsOrError(failureOrNoReturns));
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final failureOrNoReturns = await authRepository.signUp(
      signUpForm: event.signUpForm,
    );
    emit(_eitherNoReturnsOrError(failureOrNoReturns));
  }

  void _onLogout(LogoutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final failureOrNoReturns = await authRepository.logout();
    emit(_eitherLogoutOrError(failureOrNoReturns));
  }

  void _onGetUser(GetUserAuthCredentialEvent event,
      Emitter<AuthenticationState> emit) async {
    final failureOrAuthCredential =
        await authRepository.getUserAuthCredential();
    emit(_eitherLoginOrError(failureOrAuthCredential));
  }

  AuthenticationState _eitherLoginOrError(
      Either<Failure, UserData> failureOrAuthCredential) {
    return failureOrAuthCredential.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (authCredential) => authCredential.user.role == 'admin'
            ? AdminAuthenticated(userData: authCredential)
            : authCredential.user.role == 'user'
                ? UserAuthenticated(userData: authCredential)
                : ProviderAuthenticated(userData: authCredential));
  }

  AuthenticationState _eitherLogoutOrError(
      Either<Failure, NoReturns> failureOrNoReturn) {
    return failureOrNoReturn.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (_) => Unauthenticated(),
    );
  }

  AuthenticationState _eitherNoReturnsOrError(
      Either<Failure, NoReturns> failureOrNoReturns) {
    return failureOrNoReturns.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (noReturns) => LoadedNoReturns(noReturns: noReturns),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }
}
