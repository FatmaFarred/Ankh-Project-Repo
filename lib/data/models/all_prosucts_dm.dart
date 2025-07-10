import '../../domain/entities/all_products_entity.dart';

/// id : 4
/// title : "test5"
/// description : "test5"
/// views : 0
/// fuelType : "Petrol"
/// transmission : "Automatic"
/// status : "Online"
/// rating : 0
/// engineType : "ddd"
/// horsepower : 500
/// batteryCapacity : "666"
/// price : "500000 - 1000000"
/// createdAt : "2025-07-03T22:30:57.0089671"
/// lastEditedAt : "2025-07-03T22:30:57.0089677"
/// marketerName : "Omar"
/// images : ["uploads/vehicles/c40c1555-5882-42b8-b89c-b67697d2eec7.jpg","uploads/vehicles/3b5c8a61-7aa8-4844-ba7a-3882b359606b.jpg"]

class AllProductsDm extends AllProductsEntity {
  AllProductsDm({
    super.id,
    super.title,
    super.description,
    super.views,
    super.fuelType,
    super.transmission,
    super.status,
    super.rating,
    super.engineType,
    super.horsepower,
    super.batteryCapacity,
    super.price,
    super.createdAt,
    super.lastEditedAt,
    super.marketerName,
    super.images,
  });

  AllProductsDm.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    views = json['views'];
    fuelType = json['fuelType'];
    transmission = json['transmission'];
    status = json['status'];
    rating = json['rating'];
    engineType = json['engineType'];
    horsepower = json['horsepower'];
    batteryCapacity = json['batteryCapacity'];
    price = json['price'];
    createdAt = json['createdAt'];
    lastEditedAt = json['lastEditedAt'];
    marketerName = json['marketerName'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['views'] = views;
    map['fuelType'] = fuelType;
    map['transmission'] = transmission;
    map['status'] = status;
    map['rating'] = rating;
    map['engineType'] = engineType;
    map['horsepower'] = horsepower;
    map['batteryCapacity'] = batteryCapacity;
    map['price'] = price;
    map['createdAt'] = createdAt;
    map['lastEditedAt'] = lastEditedAt;
    map['marketerName'] = marketerName;
    map['images'] = images;
    return map;
  }

}