import '../../domain/entities/all_products_entity.dart';

/// id : 14
/// title : "Toyota EX30\t"
/// status : "Available"
/// price : "1000000"
/// rating : 0
/// isUsedVehicle : true
/// transmission : "Automatic"
/// image : "uploads/vehicles/f6b68b72-2390-44a5-b03b-3c373226fd30.jpg"

class AllProductsDm extends AllProductsEntity {
  AllProductsDm({
      super.id,
      super.title,
      super.status, 
      super.price, 
      super.rating, 
      super.isUsedVehicle, 
      super.transmission, 
      super.marketerPoints,
      super.image,});

  AllProductsDm.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    price = json['price'];
    rating = json['rating'];
    isUsedVehicle = json['isUsedVehicle'];
    transmission = json['transmission'];
    marketerPoints = json['marketerPoints'];
    image = json['image'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['status'] = status;
    map['price'] = price;
    map['rating'] = rating;
    map['isUsedVehicle'] = isUsedVehicle;
    map['transmission'] = transmission;
    map['marketerPoints'] = marketerPoints;
    map['image'] = image;
    return map;
  }

}