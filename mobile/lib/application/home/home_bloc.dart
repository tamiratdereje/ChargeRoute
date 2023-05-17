import 'package:bloc/bloc.dart';
import 'package:charge_station_finder/domain/core/charger.dart';
import 'package:flutter/foundation.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateInitial()) {
    on<HomeEventSearchSubmit>((event, emit) async {
      emit(HomeStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeStateSuccess(const []));
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeStateError("Error fetching results"));
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeStateSuccess(const [
        Charger(
            name: "Charger 1", wattage: 50, address: "Address 1", rating: 4),
        Charger(
            name: "Charger 2", wattage: 100, address: "Address 2", rating: 3),
        Charger(
            name: "Charger 3", wattage: 150, address: "Address 3", rating: 2),
        Charger(
            name: "Charger 4", wattage: 200, address: "Address 4", rating: 1),
        Charger(
            name: "Charger 5", wattage: 250, address: "Address 5", rating: 0),
      ]));
    });
  }
}
