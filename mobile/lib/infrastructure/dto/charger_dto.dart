import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:equatable/equatable.dart';

class ChargerDto extends Equatable {
  final String? id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final double wattage;
  final double? rating;

  const ChargerDto(this.id, this.name, this.description, this.address,
      this.phone, this.wattage, this.rating);

  factory ChargerDto.fromJson(Map<String, dynamic> json) {
    return ChargerDto(
      json['id'],
      json['name'],
      json['description'],
      json['address'],
      json['phone'],
      0.0,
      0.0,
    );
  }

  Charger toDomain() {
    return Charger(
      id: id!,
      name: name,
      description: description,
      address: address,
      phone: phone,
      wattage: wattage,
      rating: 0.0,
    );
  }

  @override
  List<Object?> get props => [id, name, description, address, phone, wattage];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'wattage': wattage,
      'rating': rating,
    };
  }
}
