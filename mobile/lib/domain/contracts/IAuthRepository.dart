import '../../application/core/failure.dart';
import '../../infrastructure/dto/userAuthCredential.dart';
import '../../utils/either.dart';
import '../auth/models/noReturn.dart';
import '../auth/models/signInFormForm.dart';
import '../auth/models/signUpForm.dart';

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
