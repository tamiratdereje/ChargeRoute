import 'package:charge_station_finder/domain/review/review.dart';

class ReviewDto {
  final String id;
  final String content;
  final String userId;
  final String chargerId;
  final String userName;

  ReviewDto(
      {required this.id,
      required this.content,
      required this.userId,
      required this.chargerId,
      required this.userName});

  factory ReviewDto.fromJson(Map<String, dynamic> json) {
    return ReviewDto(
        id: json['_id'],
        content: json['description'],
        userId: json['commentor'],
        chargerId: json['chargeStation'],
        userName: json['name'] ?? 'Anonymous');
  }

  factory ReviewDto.fromEntity(Map<String, dynamic> queryResult) {
    return ReviewDto(
        id: queryResult['id'],
        content: queryResult['description'],
        userId: queryResult['userId'],
        chargerId: queryResult['chargerId'],
        userName: queryResult['userName'] ?? 'Anonymous');
  }

  Map<String, dynamic> toEntity() {
    return {
      'id': id,
      'description': content,
      'userId': userId,
      'chargerId': chargerId,
      'userName': userName
    };
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'description': content, 'chargeStation': chargerId};
  }

  Review toDomain() => Review(
        id: id,
        content: content,
        userId: userId,
        chargerId: chargerId,
        userName: userName,
      );
}
