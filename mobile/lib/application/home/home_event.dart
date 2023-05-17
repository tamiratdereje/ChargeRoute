part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeEventSearchSubmit extends HomeEvent {
  final String query;
  final double minWattage;

  HomeEventSearchSubmit(this.query, this.minWattage);
}
