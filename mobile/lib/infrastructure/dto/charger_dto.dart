import 'package:charge_station_finder/domain/charger/charger.dart';
import 'package:charge_station_finder/infrastructure/dto/review_dto.dart';
import 'package:equatable/equatable.dart';

class ChargerDto extends Equatable {
  final String? id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final double wattage;
  final bool hasUserRated;
  final double? rating;
  final String? user;
  final List<ReviewDto> reviews;

  const ChargerDto(
      this.id,
      this.name,
      this.description,
      this.address,
      this.phone,
      this.wattage,
      this.rating,
      this.hasUserRated,
      this.user,
      this.reviews);

  factory ChargerDto.fromJson(Map<String, dynamic> json) {
    return ChargerDto(
      json['_id'],
      json['name'],
      json['description'],
      json['address'],
      json['phone'],
      (json['wattage'] as double?) ?? -1000,
      json['rating']!.toDouble(),
      json['voted'],
      json['user'],
      ((json['comments'] ?? []) as List)
          .map((e) => ReviewDto.fromJson(e))
          .toList(growable: false),
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
      hasUserRated: hasUserRated,
      authorId: user!,
      reviews: reviews.map((e) => e.toDomain()).toList(),
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
