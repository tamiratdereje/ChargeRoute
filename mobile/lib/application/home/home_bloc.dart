import 'package:bloc/bloc.dart';
import 'package:charge_station_finder/domain/charger/charger.dart';
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
      emit(HomeStateSuccess(const []));
    });
  }
}
