class Review {
  final String id;
  final String userId;
  final String content;
  final String chargerId;

  const Review({
    required this.id,
    required this.userId,
    required this.content,
    required this.chargerId
  });

  Review copyWith({
    String? id,
    String? userId,
    String? content,
    String? chargerId
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      chargerId: chargerId ?? this.chargerId
    );
  }
}
