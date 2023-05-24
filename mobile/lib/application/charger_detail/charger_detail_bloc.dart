import 'package:charge_station_finder/domain/review/review.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/charger/charger_detail.dart';

part 'charger_detail_event.dart';
part 'charger_detail_state.dart';

class ChargerDetailBloc extends Bloc<ChargerDetailEvent, ChargerDetailState> {
  ChargerDetail chargerDetail = const ChargerDetail(
    id: "1",
    name: "Charger 1",
    address: "Address 1",
    description: "Description 1",
    phone: "Phone 1",
    rating: 4,
    wattage: 50,
    reviews: [
      Review(
        id: "1",
        userId: "1",
        content: "Content 1",
      ),
      Review(
        id: "2",
        userId: "2",
        content: "Content 2",
      ),
      Review(
        id: "3",
        userId: "3",
        content: "Content 3",
      ),
    ],
  );

  ChargerDetailBloc() : super(ChargerDetailStateInitial()) {
    on<ChargerDetailEventPostReview>((event, emit) async {
      emit(ChargerDetailStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      chargerDetail.reviews
          .add(Review(id: "asd", userId: "adf", content: event.content));
      emit(ChargerDetailStateReviewPosted(chargerDetail));
    });

    on<ChargerDetailEventDeleteReview>((event, emit) async {
      emit(ChargerDetailStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      chargerDetail = chargerDetail.copyWith(
          reviews: chargerDetail.reviews
              .where((element) => element.id != event.reviewId)
              .toList());
      emit(ChargerDetailStateReviewDeleted(chargerDetail));
    });

    on<ChargerDetailEventUpdateReview>((event, emit) async {
      emit(ChargerDetailStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      chargerDetail = chargerDetail.copyWith(
          reviews: chargerDetail.reviews.map((element) {
        if (element.id != event.reviewId)
          return element;
        else
          return element.copyWith(content: event.content);
      }).toList());
      emit(ChargerDetailStateReviewUpdated(chargerDetail));
    });

    on<ChargerDetailEventLoad>((event, emit) async {
      emit(ChargerDetailStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(
        ChargerDetailStateLoaded(chargerDetail),
      );
    });
  }
}
