import 'package:charge_station_finder/domain/review/review.dart';

class Charger {
  final String id;
  final String name;
  final String address;
  final double rating;
  final double wattage;
  final String description;
  final String phone;
  late final List<Review> reviews;
  final String authorId;
  final bool hasUserRated;
  final int userVote;

  Charger(
      {required this.id,
      required this.name,
      required this.address,
      required this.rating,
      required this.wattage,
      required this.description,
      required this.phone,
      required this.reviews,
      required this.authorId,
      required this.hasUserRated,
      required this.userVote});

  String toString() {
    return 'Charger(id: $id, name: $name, address: $address, rating: $rating, wattage: $wattage, description: $description, phone: $phone, reviews: $reviews, authorId: $authorId, hasUserRated: $hasUserRated, userVote: $userVote)';
  }
}
