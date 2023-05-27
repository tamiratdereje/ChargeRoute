import 'package:charge_station_finder/domain/charger/charger_repository_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/charger/charger_detail.dart';
import '../../domain/review/review_repository_interface.dart';

part 'charger_detail_event.dart';
part 'charger_detail_state.dart';

class ChargerDetailBloc extends Bloc<ChargerDetailEvent, ChargerDetailState> {
  ChargerDetail? chargerDetail;
  final ChargerRepositoryInterface chargerRepository;
  final ReviewRepositoryInterface reviewRepository;

  ChargerDetailBloc(
      {required this.chargerRepository, required this.reviewRepository})
      : super(ChargerDetailStateInitial()) {
    on<ChargerDetailEventDeleteCharger>((event, emit) async {
      emit(ChargerDetailStateLoading());
      var res = await chargerRepository.deleteCharger(event.chargerId);
      res.fold((l) => emit(ChargerDetailStateError(l.message)),
          (r) => emit(ChargerDetailStateChargerDeleted()));
    });

    on<ChargerDetailEventPostReview>((event, emit) async {
      emit(ChargerDetailStateLoading());
      var res =
          await reviewRepository.addReview(event.content, event.chargerId);
      res.fold((l) => emit(ChargerDetailStateError(l.message)), (r) {
        chargerDetail!.reviews.add(r);
        emit(ChargerDetailStateReviewPosted(chargerDetail!));
      });
    });

    on<ChargerDetailEventDeleteReview>((event, emit) async {
      emit(ChargerDetailStateLoading());
      chargerDetail = chargerDetail!.copyWith(
          reviews: chargerDetail!.reviews
              .where((element) => element.id != event.reviewId)
              .toList());
      emit(ChargerDetailStateReviewDeleted(chargerDetail!));
    });

    on<ChargerDetailEventUpdateReview>((event, emit) async {
      emit(ChargerDetailStateLoading());
      chargerDetail = chargerDetail!.copyWith(
          reviews: chargerDetail!.reviews.map((element) {
        if (element.id != event.reviewId)
          return element;
        else
          return element.copyWith(content: event.content);
      }).toList());
      emit(ChargerDetailStateReviewUpdated(chargerDetail!));
    });

    on<ChargerDetailEventLoad>((event, emit) async {
      emit(ChargerDetailStateLoading());
      var res = await chargerRepository.getChargerDetail(event.chargerId);

      res.fold((l) => emit(ChargerDetailStateError(l.message)), (r) {
        chargerDetail = r;
        emit(ChargerDetailStateLoaded(chargerDetail!));
      });
    });
  }
}
