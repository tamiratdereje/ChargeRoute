part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeStateInitial extends HomeState {
  HomeStateInitial();
}

class HomeStateLoading extends HomeState {
  HomeStateLoading();
}

class HomeStateSuccess extends HomeState {
  final List<Charger> results;

  HomeStateSuccess(this.results);
}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);
}
