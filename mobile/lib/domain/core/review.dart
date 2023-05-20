class Review {
  final String id;
  final String userId;
  final String content;

  const Review({
    required this.id,
    required this.userId,
    required this.content,
  });

  Review copyWith({
    String? id,
    String? userId,
    String? content,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
    );
  }
}
