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
  tearDown(() {
    chargerDetailBloc.close();
  });

  group('ChargerDetailBloc', () {
    // test('initial state should be ChargeDetailStateInitial', () {
    //   expect(chargerDetailBloc.state, ChargerDetailStateInitial());
    // });


// ...

test('emits ChargerDetailStateLoaded when charger detail loading succeeds', () async {
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

  // act
  chargerDetailBloc.add(ChargerDetailEventLoad(chargerId));

  // assert
  await expectLater(
    chargerDetailBloc.stream,
    emitsInOrder([
      isA<ChargerDetailStateLoading>(),
      isA<ChargerDetailStateLoaded>().having((state) => state.charger, 'chargerDetail', chargerDetail),
    ]),
  );
});

test('emits ChargerDetailStateError when charger detail loading fails', () async {
  final chargerId = 'charger_123';
  final errorMessage = 'Failed to load charger detail';

  when(chargerRepository.getChargerDetail(chargerId)).thenAnswer((_) async {
    return Left(Failure(errorMessage));
  });

  // act
  chargerDetailBloc.add(ChargerDetailEventLoad(chargerId));

  // assert
  await expectLater(
    chargerDetailBloc.stream,
    emitsInOrder([
      isA<ChargerDetailStateLoading>(),
      isA<ChargerDetailStateError>().having((state) => state.message, 'message', errorMessage),
    ]),
  );
});


  });
}
