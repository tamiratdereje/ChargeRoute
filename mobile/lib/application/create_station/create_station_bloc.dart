import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/charger/charger_form.dart';
import '../../domain/charger/charger_repository_interface.dart';

part 'create_station_event.dart';
part 'create_station_state.dart';

class CreateStationBloc extends Bloc<CreateStationEvent, CreateStationState> {
  ChargerRepositoryInterface chargerRepository;

  CreateStationBloc(this.chargerRepository) : super(CreateStationInitial()) {
    on<CreateStationSubmitEvent>((event, emit) async {
      emit(CreateStationLoading());

      var res = await chargerRepository.addCharger(
        ChargerForm(
          name: event.name,
          description: event.description,
          address: event.address,
          phone: event.phone,
          wattage: event.wattage,
        ),
      );

      res.fold((l) => emit(CreateStationFailure(message: l.message)), (r) {
        emit(CreateStationSuccess());
      });
    });
  }
}
