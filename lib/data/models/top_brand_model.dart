import 'package:ankh_project/domain/entities/top_brand_entity.dart';

class TopBrandModel extends TopBrandEntity {
  TopBrandModel({
    required int id,
    required String name,
    required String imageUrl,
  }) : super(id: id, name: name, imageUrl: imageUrl);

  factory TopBrandModel.fromJson(Map<String, dynamic> json) {
    return TopBrandModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
