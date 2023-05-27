import 'package:charge_station_finder/domain/review/review.dart';

class ReviewDto {
  final String id;
  final String content;
  final String userId;

  ReviewDto({
    required this.id,
    required this.content,
    required this.userId,
  });

  factory ReviewDto.fromJson(Map<String, dynamic> json) {
    return ReviewDto(
      id: json['_id'],
      content: json['description'],
      userId: json['commentor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'description': content,
      'commentor': userId,
    };
  }

  Review toDomain() => Review(
        id: id,
        content: content,
        userId: userId,
      );
}
