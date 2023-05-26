import 'package:charge_station_finder/common/failure.dart';
import 'package:charge_station_finder/domain/review/review_repository_interface.dart';
import 'package:dartz/dartz.dart';

import '../../common/exceptions/ApiException.dart';
import '../../common/exceptions/ServerException.dart';
import '../../utils/custom_http_client.dart';
import '../data-source/remote/review_service.dart';

class ReviewRepositoryImpl extends ReviewRepositoryInterface {
  late final RemoteReviewSource remoteReviewSource;

  ReviewRepositoryImpl({required CustomHttpClient httpClient}) {
    remoteReviewSource = RemoteReviewSource(httpClient);
  }

  @override
  Future<Either<Failure, void>> addReview(
      String content, String chargerId) async {
    try {
      await remoteReviewSource.addReview(chargerId, content);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReview(
      String chargerId, String reviewId) async {
    try {
      await remoteReviewSource.deleteReview(chargerId, reviewId);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editReview(
      String content, String reviewId, String chargerId) async {
    try {
      await remoteReviewSource.editReview(chargerId, reviewId, content);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on ApiException catch (e) {
      return left(Failure(e.message));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}