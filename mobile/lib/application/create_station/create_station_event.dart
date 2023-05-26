part of 'create_station_bloc.dart';

@immutable
abstract class CreateStationEvent {}

class CreateStationSubmitEvent extends CreateStationEvent {
  final String name;
  final String description;
  final String address;
  final String phone;
  final double wattage;

  CreateStationSubmitEvent({
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.wattage,
  });
}
