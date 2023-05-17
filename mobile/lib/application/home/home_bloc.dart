import 'package:bloc/bloc.dart';
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
        {
          "name": "Shell SuperCharger ",
          "address": "123 Main St",
          "rating": "1.233",
        },
        {
          "name": "Noc Charger",
          "address": "253 Main St",
          "rating": "4.2",
        },
        {
          "name": "Shell SuperCharger ",
          "address": "123 Main St",
          "rating": "1.233",
        },
        {
          "name": "Noc Charger",
          "address": "253 Main St",
          "rating": "4.2",
        },
        {
          "name": "Shell SuperCharger ",
          "address": "123 Main St",
          "rating": "1.233",
        },
        {
          "name": "Noc Charger",
          "address": "253 Main St",
          "rating": "4.2",
        },
        {
          "name": "Shell SuperCharger ",
          "address": "123 Main St",
          "rating": "1.233",
        },
      ]));
    });
  }
}
