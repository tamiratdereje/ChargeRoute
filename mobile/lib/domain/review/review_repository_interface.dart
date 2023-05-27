import 'package:charge_station_finder/common/failure.dart';
import 'package:charge_station_finder/domain/review/review.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewRepositoryInterface {
  Future<Either<Failure, Review>> addReview(String content, String chargerId);

  Future<Either<Failure, void>> editReview(
      String content, String reviewId, String chargerId);

  Future<Either<Failure, void>> deleteReview(String reviewId);
}
