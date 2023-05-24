part of 'charger_detail_bloc.dart';

@immutable
abstract class ChargerDetailEvent {}

class ChargerDetailEventLoad extends ChargerDetailEvent {
  final String chargerId;

  ChargerDetailEventLoad(this.chargerId);
}

class ChargerDetailEventPostReview extends ChargerDetailEvent {
  final String chargerId;
  final String content;

  ChargerDetailEventPostReview(this.chargerId, this.content);
}

class ChargerDetailEventDeleteReview extends ChargerDetailEvent {
  final String reviewId;

  ChargerDetailEventDeleteReview(this.reviewId);
}

class ChargerDetailEventUpdateReview extends ChargerDetailEvent {
  final String reviewId;
  final String content;

  ChargerDetailEventUpdateReview(this.reviewId, this.content);
}
