import 'package:bloc/bloc.dart';
import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:flutter/foundation.dart';
import '../../domain/charger/charger_repository_interface.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ChargerRepositoryInterface chargerRepository;

  HomeBloc({required this.chargerRepository}) : super(HomeStateInitial()) {
    on<HomeEventSearchSubmit>((event, emit) async {
      emit(HomeStateLoading());
      var local_result = 
          await chargerRepository.getChargersByAddress(event.query);
      local_result.fold((failure) {
        null;
      }, (chargers) {
        emit(HomeStateSuccess(chargers));
      });
      var remote_result = await chargerRepository.fetchChargers(event.query);
      remote_result.fold((l) => HomeStateError(l.message), (r) => emit(HomeStateSuccess(r)));
    });
  }

}
