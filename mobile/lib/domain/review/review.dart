class Review {
  final String id;
  final String userId;
  final String content;
  final String chargerId;
  final String userName;

  const Review(
      {required this.id,
      required this.userId,
      required this.content,
      required this.chargerId,
      required this.userName});

  Review copyWith(
      {String? id,
      String? userId,
      String? content,
      String? chargerId,
      String? userName}) {
    return Review(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        content: content ?? this.content,
        chargerId: chargerId ?? this.chargerId,
        userName: userName ?? this.userName);
  }
}
