part of 'charger_detail_bloc.dart';

@immutable
abstract class ChargerDetailState {}

class ChargerDetailStateLoading extends ChargerDetailState {}

class ChargerDetailStateLoaded extends ChargerDetailState {
  final ChargerDetail charger;

  ChargerDetailStateLoaded(this.charger);
}

class ChargerDetailStateChargerDeleted extends ChargerDetailState {}

class ChargerDetailStateError extends ChargerDetailState {
  final String message;

  ChargerDetailStateError(this.message);
}

class ChargerDetailStateReviewPosted extends ChargerDetailStateLoaded {
  ChargerDetailStateReviewPosted(super.charger);
}

class ChargerDetailStateReviewDeleted extends ChargerDetailStateLoaded {
  ChargerDetailStateReviewDeleted(super.charger);
}

class ChargerDetailStateReviewUpdated extends ChargerDetailStateLoaded {
  ChargerDetailStateReviewUpdated(super.charger);
}

class ChargerDetailStateInitial extends ChargerDetailState {}
