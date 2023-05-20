import 'package:charge_station_finder/domain/core/review.dart';

class ChargerDetail {
  final String id;
  final String name;
  final String description;
  final String phone;
  final String address;
  final double rating;
  final double wattage;

  final List<Review> reviews;

  const ChargerDetail({
    required this.id,
    required this.description,
    required this.phone,
    required this.name,
    required this.address,
    required this.rating,
    required this.wattage,
    required this.reviews,
  });

  ChargerDetail copyWith({
    String? id,
    String? name,
    String? description,
    String? phone,
    String? address,
    double? rating,
    double? wattage,
    List<Review>? reviews,
  }) {
    return ChargerDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      wattage: wattage ?? this.wattage,
      reviews: reviews ?? this.reviews,
    );
  }
}
