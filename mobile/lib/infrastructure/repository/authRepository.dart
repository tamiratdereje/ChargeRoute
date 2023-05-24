import 'package:charge_station_finder/application/core/failure.dart';
import 'package:charge_station_finder/domain/auth/models/noReturn.dart';
import 'package:charge_station_finder/domain/auth/models/signInFormForm.dart';
import 'package:charge_station_finder/domain/auth/models/signUpForm.dart';
import 'package:charge_station_finder/infrastructure/dto/SignInDto.dart';
import 'package:charge_station_finder/infrastructure/dto/userAuthCredential.dart';
import 'package:charge_station_finder/domain/contracts/IAuthRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import '../core/constants.dart';
import '../data-source/local/sharedPrefHelper.dart';
import '../data-source/remote/authService.dart';
import '../dto/SignUpDto.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  var _authenticationService = AuthenticationService();


  @override
  Future<Either<Failure, NoReturns>> changePassword(
      {required String otpToken, required String newPassword}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserAuthCredential>> getUserAuthCredential() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserAuthCredential>> login(
      {required SignInForm signInForm}) async {
    try {
      var response =
          await _authenticationService.signIn(SignInDto.fromForm(signInForm));
      await ShardPrefHelper.setString(Constants.User_Key, response.toJson().toString());
      return Future.value(Right(response));
    } catch (e) {
      debugPrint(e.toString());
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, NoReturns>> logout() {
    try {
      return _authenticationService.signOut().then((value) => Right(value));
    } catch (e) {
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, NoReturns>> signUp(
      {required SignUpForm signUpForm}) async {
    try {
      var response =
          await _authenticationService.signUp(SignUpDto.fromForm(signUpForm));
      return Future.value(Right(response));
    } catch (e) {
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, NoReturns>> deleteAccount() {
    try{
      return _authenticationService.deleteAccount().then((value) => Right(value));
    }catch(e){
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }
}
