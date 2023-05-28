import 'package:charge_station_finder/application/home/home_bloc.dart';
import 'package:charge_station_finder/common/failure.dart';
import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:charge_station_finder/domain/charger/charger_repository_interface.dart';
import 'package:charge_station_finder/utils/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'charge_detail_bloc_test.mocks.dart';

// Import the generated mock class
// Use the @GenerateMocks annotation to generate the mock
@GenerateMocks([ChargerRepositoryInterface])
void main() {
  late ChargerRepositoryInterface chargerRepository;
  late HomeBloc homeBloc;
  setUp(() {
    chargerRepository = MockChargerRepositoryInterface();
    homeBloc = HomeBloc(chargerRepository: chargerRepository);
  });

  tearDown(() {
    homeBloc.close();
  });

  group('HomeBloc', () {
    final charger1 = Charger(
      id: 'charger1',
      name: 'Charger 1',
      address: 'Address 1',
      rating: 4.5,
      wattage: 50.0,
      description: 'Charger 1 description',
      phone: '1234567890',
      reviews: [],
      authorId: 'author1',
      hasUserRated: false,
      userVote: 0,
    );

    final charger2 = Charger(
      id: 'charger2',
      name: 'Charger 2',
      address: 'Address 2',
      rating: 3.8,
      wattage: 60.0,
      description: 'Charger 2 description',
      phone: '0987654321',
      reviews: [],
      authorId: 'author2',
      hasUserRated: true,
      userVote: 5,
    );

    final chargers = [charger1, charger2];

    test(
        'emits [HomeStateLoading, HomeStateSuccess] when charger search is successful',
        () {
      const query = 'New York';
      const minWattage = 50.0;

      when(chargerRepository.getChargersByAddress(query)).thenAnswer((_) async {
        return Right(chargers);
      });

      final bloc = HomeBloc(chargerRepository: chargerRepository);

      bloc.stream.listen((state) {
        if (state is HomeStateSuccess) {
          expect(state.results, chargers);
        }
      });

      bloc.add(HomeEventSearchSubmit(query, minWattage));
    });

    test('emits [HomeStateLoading, HomeStateError] when charger search fails',
        () {
      const query = 'New York';
      const errorMessage = 'Failed to fetch chargers';

      when(chargerRepository.getChargersByAddress(query)).thenAnswer((_) async {
        return Left(Failure(errorMessage));
      });

      final bloc = HomeBloc(chargerRepository: chargerRepository);

      bloc.stream.listen((state) {
        if (state is HomeStateError) {
          expect(state.message, errorMessage);
        }
      });

      bloc.add(HomeEventSearchSubmit(query, 0.0));
    });
  });
}
