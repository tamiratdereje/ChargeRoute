
import 'package:charge_station_finder/presentation/pages/auth/signUp.dart';
import 'package:dartz/dartz.dart';
import '../../application/core/failure.dart';
import '../auth/models/noReturn.dart';
import '../auth/models/signInFormForm.dart';
import '../auth/models/signUpForm.dart';
import '../../infrastructure/dto/userAuthCredential.dart';

abstract class IAuthenticationRepository {
  Future<Either<Failure, UserData>> login({
    required SignInForm signInForm,
  });
  Future<Either<Failure, NoReturns>> logout();
  Future<Either<Failure, UserData>> getUserAuthCredential();
  Future<Either<Failure, NoReturns>> signUp({
    required SignUpForm signUpForm,
  });
  Future<Either<Failure, NoReturns>> deleteAccount();
  Future<Either<Failure, NoReturns>> changePassword({
    required String otpToken,
    required String newPassword,
  });
}