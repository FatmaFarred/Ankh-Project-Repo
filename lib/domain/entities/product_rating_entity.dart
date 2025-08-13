class ProductRatingEntity {
  final num productId;
  final String userId;
  final num stars;
  final String comment;

  ProductRatingEntity({
    required this.productId,
    required this.userId,
    required this.stars,
    required this.comment,
  });
}