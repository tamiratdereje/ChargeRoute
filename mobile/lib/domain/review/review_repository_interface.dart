import 'package:charge_station_finder/common/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewRepositoryInterface {
  Future<Either<Failure, void>> addReview(String content, String chargerId);

  Future<Either<Failure, void>> editReview(
      String content, String reviewId, String chargerId);

  Future<Either<Failure, void>> deleteReview(String chargerId, String reviewId);
}
