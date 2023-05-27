import 'package:charge_station_finder/application/admin/admin_bloc.dart';
import 'package:charge_station_finder/domain/admin/admin_model.dart';
import 'package:charge_station_finder/infrastructure/admin/admin_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'admin_bloc_test.mocks.dart';

@GenerateMocks([AdminRepository])

void main() {
  group('AdminBloc', () {
    
    late AdminBloc adminBloc;
    late MockAdminRepository mockAdminRepository;

    setUp(() {
      mockAdminRepository = MockAdminRepository();
      adminBloc = AdminBloc(adminRepository: mockAdminRepository);
    });

    tearDown(() {
      adminBloc.close();
    });

    test('initial state is AdminLoadingState', () {
      expect(adminBloc.state, AdminLoadingState());
    });

    test('emits AdminSuccessState when AdminGetUsersEvent is added', () {
      final mockAdminDomains = [
        AdminDomain(
          id: '1',
          name: 'John Doe',
          email: 'johndoe@example.com',
          role: 'admin',
        ),
        AdminDomain(
          id: '2',
          name: 'Jane Smith',
          email: 'janesmith@example.com',
          role: 'admin',
        ),
      ];

      when(mockAdminRepository.getUsers()).thenAnswer((_) async => mockAdminDomains);

      final expectedStates = [
        AdminLoadingState(),
        AdminSuccessState(adminDomains: mockAdminDomains),
      ];

      expectLater(adminBloc.stream, emitsInOrder(expectedStates));

      adminBloc.add(AdminGetUsersEvent());
    });

    test('emits AdminSuccessState when AdminCreateUserEvent is added', () {
      final mockAdminDomain = AdminDomain(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        role: 'admin',
      );

      when(mockAdminRepository.createUser(mockAdminDomain)).thenAnswer((_) async {});

      final expectedStates = [
        AdminLoadingState(),
        AdminSuccessState(adminDomains: [mockAdminDomain]),
      ];

      expectLater(adminBloc.stream, emitsInOrder(expectedStates));

      adminBloc.add(AdminCreateUserEvent(adminDomain: mockAdminDomain));
    });

    // Add more tests for other events as needed

    // Add additional setup and mocking as necessary for your tests
  });
}
