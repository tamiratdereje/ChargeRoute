part of 'create_station_bloc.dart';

@immutable
abstract class CreateStationState {}

class CreateStationInitial extends CreateStationState {}

class CreateStationLoading extends CreateStationState {}

class CreateStationSuccess extends CreateStationState {}

class CreateStationFailure extends CreateStationState {
  final String message;

  CreateStationFailure({required this.message});
}
