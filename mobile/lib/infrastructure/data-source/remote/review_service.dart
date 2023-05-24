import '../../../utils/custom_http_client.dart';

class RemoteReviewSource {
  final CustomHttpClient httpClient;

  RemoteReviewSource(this.httpClient);

  Future<void> addReview(String chargerId, String review) async {
    httpClient.post('/chargeStation/$chargerId/comment', body: {
      'review': review,
    });
  }

  Future<void> deleteReview(String chargerId, String reviewId) async {
    httpClient.delete('/chargeStation/$chargerId/comment/$reviewId');
  }

  Future<void> editReview(
      String chargerId, String reviewId, String review) async {
    httpClient.put('/chargeStation/$chargerId/comment/$reviewId', body: {
      'review': review,
    });
  }
}
