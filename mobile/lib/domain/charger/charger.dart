import 'package:charge_station_finder/domain/review/review.dart';

class Charger {
  final String id;
  final String name;
  final String address;
  final double rating;
  final double wattage;
  final String description;
  final String phone;
  final List<Review> reviews;
  final String authorId;
  final bool hasUserRated;

  const Charger(
      {required this.id,
      required this.name,
      required this.address,
      required this.rating,
      required this.wattage,
      required this.description,
      required this.phone,
      required this.reviews,
      required this.authorId,
      required this.hasUserRated});
}
