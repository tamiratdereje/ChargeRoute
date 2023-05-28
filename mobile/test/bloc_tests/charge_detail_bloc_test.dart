import 'package:charge_station_finder/application/charger_detail/charger_detail_bloc.dart';
import 'package:charge_station_finder/common/failure.dart';
import 'package:charge_station_finder/domain/charger/charger_detail.dart';
import 'package:charge_station_finder/domain/charger/charger_repository_interface.dart';
import 'package:charge_station_finder/domain/review/review_repository_interface.dart';
import 'package:charge_station_finder/utils/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import the generated mock classes
import 'charge_detail_bloc_test.mocks.dart';

// Use the @GenerateMocks annotation to generate the mocks
@GenerateMocks([
  ChargerRepositoryInterface,
  ReviewRepositoryInterface,
])
void main() {
  late MockChargerRepositoryInterface chargerRepository;
  late MockReviewRepositoryInterface reviewRepository;
  late ChargerDetailBloc chargerDetailBloc;

  setUp(() {
    chargerRepository = MockChargerRepositoryInterface();
    reviewRepository = MockReviewRepositoryInterface();
    chargerDetailBloc = ChargerDetailBloc(
      chargerRepository: chargerRepository,
      reviewRepository: reviewRepository,
    );
  });

  group('ChargerDetailBloc', () {
    test('emits ChargerDetailStateLoaded when charger detail loading succeeds',
        () {
      final chargerId = 'charger_123';
      final chargerDetail = ChargerDetail(
        id: chargerId,
        description: 'Charger description',
        phone: '1234567890',
        name: 'Charger name',
        address: 'Charger address',
        rating: 4.5,
        wattage: 50.0,
        reviews: [],
        hasUserRated: false,
        user: 'User name',
        userVote: 0,
      );

      when(chargerRepository.getChargerDetail(chargerId)).thenAnswer((_) async {
        return Right(chargerDetail);
      });

      expectLater(
        chargerDetailBloc.stream,
        emitsInOrder([
          isA<ChargerDetailStateLoading>(),
          ChargerDetailStateLoaded(chargerDetail),
        ]),
      );
      // then((_) {
      //   verify(chargerRepository.getChargerDetail(chargerId)).called(1);
      // });

      // chargerDetailBloc.add(ChargerDetailEventLoad(chargerId));
    });

    test('emits ChargerDetailStateError when charger detail loading fails', () {
      final chargerId = 'charger_123';
      final errorMessage = 'Failed to load charger detail';

      when(chargerRepository.getChargerDetail(chargerId)).thenAnswer((_) async {
        return Left(Failure(errorMessage));
      });

      expectLater(
        chargerDetailBloc.stream,
        emitsInOrder([
          isA<ChargerDetailStateLoading>(),
          ChargerDetailStateError(errorMessage),
        ]),
      );
      // then((_) {
      //   verify(chargerRepository.getChargerDetail(chargerId)).called(1);
      // });

      // chargerDetailBloc.add(ChargerDetailEventLoad(chargerId));
    });
  });
}
