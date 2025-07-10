import 'package:ankh_project/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required int id,
    required String title,
    required String status,
    required String price,
    required double rating,
    required String transmission,
    required String image,
  }) : super(
         id: id,
         title: title,
         status: status,
         price: price,
         rating: rating,
         transmission: transmission,
         image: image,
       );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      price: json['price'],
      rating: (json['rating'] as num).toDouble(),
      transmission: json['transmission'],
      image: json['image'],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      status: status,
      price: price,
      rating: rating,
      transmission: transmission,
      image: image,
    );
  }
}
