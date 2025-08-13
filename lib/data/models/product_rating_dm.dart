import 'package:ankh_project/domain/entities/product_rating_entity.dart';

class ProductRatingDm extends ProductRatingEntity {
  ProductRatingDm({
    required num productId,
    required String userId,
    required num stars,
    required String comment,
  }) : super(
          productId: productId,
          userId: userId,
          stars: stars,
          comment: comment,
        );

  factory ProductRatingDm.fromJson(Map<String, dynamic> json) {
    return ProductRatingDm(
      productId: json['productId'],
      userId: json['userId'],
      stars: json['stars'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'stars': stars,
      'comment': comment,
    };
  }

  ProductRatingEntity toEntity() {
    return ProductRatingEntity(
      productId: productId,
      userId: userId,
      stars: stars,
      comment: comment,
    );
  }
}