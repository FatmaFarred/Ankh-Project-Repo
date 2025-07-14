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

class AllProductsEntity {
  AllProductsEntity({
      this.id, 
      this.title, 
      this.description, 
      this.views, 
      this.fuelType, 
      this.transmission, 
      this.status, 
      this.rating, 
      this.engineType, 
      this.horsepower, 
      this.batteryCapacity, 
      this.price, 
      this.createdAt, 
      this.lastEditedAt, 
      this.marketerName, 
      this.images,});

  num? id;
  String? title;
  String? description;
  num? views;
  String? fuelType;
  String? transmission;
  String? status;
  num? rating;
  String? engineType;
  num? horsepower;
  String? batteryCapacity;
  String? price;
  String? createdAt;
  String? lastEditedAt;
  String? marketerName;
  List<String>? images;


}