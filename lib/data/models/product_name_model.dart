import 'package:ankh_project/domain/entities/product_name_entity.dart';

class ProductNameModel extends ProductNameEntity {
  ProductNameModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory ProductNameModel.fromJson(Map<String, dynamic> json) {
    return ProductNameModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}