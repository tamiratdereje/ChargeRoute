import 'package:equatable/equatable.dart';

class ChargerForm extends Equatable {
  final String name;
  final String description;
  final String phone;
  final String address;
  final double rating;
  final double wattage;

  const ChargerForm({
    required this.name,
    required this.description,
    required this.phone,
    required this.address,
    required this.rating,
    required this.wattage,
  });

  String toJson() {
    return '''
    {
      "name": "$name",
      "description": "$description",
      "phone": "$phone",
      "address": "$address",
      "rating": $rating,
      "wattage": $wattage
    }
    ''';
  }

  @override
  List<Object?> get props =>
      [name, description, phone, address, rating, wattage];
}
