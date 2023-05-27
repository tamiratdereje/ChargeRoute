import 'package:charge_station_finder/domain/review/review.dart';

class ReviewDto {
  final String id;
  final String content;
  final String userId;
  final String chargerId;

  ReviewDto(
      {required this.id,
      required this.content,
      required this.userId,
      required this.chargerId});

  factory ReviewDto.fromJson(Map<String, dynamic> json) {
    return ReviewDto(
        id: json['_id'],
        content: json['description'],
        userId: json['commentor'],
        chargerId: json['chargeStation']);
  }

  factory ReviewDto.fromEntity(Map<String, dynamic> queryResult) {
    return ReviewDto(
        id: queryResult['id'],
        content: queryResult['comment'],
        userId: queryResult['userId'],
        chargerId: queryResult['chargerId']);
  }

  Map<String, dynamic> toEntity() {
    return {
      'id': id,
      'description': content,
      'userId': userId,
      'chargerId': chargerId
    };
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'description': content,
      'commentor': userId,
      'chargeStation': chargerId
    };
  }

  Review toDomain() =>
      Review(id: id, content: content, userId: userId, chargerId: chargerId);
}
