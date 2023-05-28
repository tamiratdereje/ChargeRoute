import 'package:charge_station_finder/application/auth/auth_bloc.dart';
import 'package:charge_station_finder/application/core/failure.dart';
import 'package:charge_station_finder/domain/auth/models/signInFormForm.dart';
import 'package:charge_station_finder/domain/auth/models/signUpForm.dart';
import 'package:charge_station_finder/domain/contracts/IAuthRepository.dart';
import 'package:charge_station_finder/infrastructure/dto/userAuthCredential.dart';
import 'package:charge_station_finder/utils/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

// Import the generated mocks file
// import 'auth_bloc_test.mocks.dart';

// Add the @GenerateMocks annotation to generate mocks
@GenerateMocks([IAuthenticationRepository])
void main() {
  late AuthenticationBloc authenticationBloc;
  late MockIAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockIAuthenticationRepository();
    authenticationBloc = AuthenticationBloc(
      authRepository: mockAuthenticationRepository,
    );
  });

  tearDown(() {
    authenticationBloc.close();
  });

  group('AuthenticationBloc', () {
    test('initial state should be AuthenticationStateInitial', () {
      expect(authenticationBloc.state, AuthenticationStateInitial());
    });

    test(
        'should emit AuthenticationLoading and AuthenticationStateUserAuthenticated when LoginEvent is added and login is successful',
        () {
      // Arrange
      final signInForm = SignInForm(
        email: 'test@example.com',
        password: 'password123',
      );
      final userAuthCredential = UserAuthCredential(
        id: '123',
        name: 'John Doe',
        email: 'test@example.com',
        role: 'user',
        password: 'password123',
        createdAt: '2022-01-01',
      );
      final userData = UserData(
        user: userAuthCredential,
        token: 'abc123',
      );
      when(mockAuthenticationRepository.login(signInForm: signInForm))
          .thenAnswer((_) async => Right(userData));

      // Act
      authenticationBloc.add(LoginEvent(signInForm: signInForm));

      // Assert
      final expectedStates = [
        AuthenticationLoading(),
        AuthenticationStateUserAuthenticated(userData: userData),
      ];
      expectLater(authenticationBloc.stream, emitsInOrder(expectedStates));
    });

    test(
        'should emit AuthenticationLoading and AuthenticationStateError when LoginEvent is added and login fails',
        () {
      // Arrange
      final signInForm = SignInForm(
        email: 'test@example.com',
        password: 'password123',
      );
      final failure = ServerFailure(message: 'Login failed');
      when(mockAuthenticationRepository.login(signInForm: signInForm))
          .thenAnswer((_) async => Left(failure));

      // Act
      authenticationBloc.add(LoginEvent(signInForm: signInForm));

      // Assert
      final expectedStates = [
        AuthenticationLoading(),
        AuthenticationStateError(message: failure.toString()),
      ];
      expectLater(authenticationBloc.stream, emitsInOrder(expectedStates));
    });

    // Add more test cases for other events and scenarios

    // ...
  });
}
