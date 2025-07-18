/// id : 14
/// title : "Toyota EX30\t"
/// status : "Available"
/// price : "1000000"
/// rating : 0
/// isUsedVehicle : true
/// transmission : "Automatic"
/// image : "uploads/vehicles/f6b68b72-2390-44a5-b03b-3c373226fd30.jpg"

class AllProductsEntity {
  AllProductsEntity({
      this.id, 
      this.title, 
      this.status, 
      this.price, 
      this.rating, 
      this.isUsedVehicle, 
      this.transmission, 
      this.image,});

  num? id;
  String? title;
  String? status;
  String? price;
  num? rating;
  bool? isUsedVehicle;
  String? transmission;
  String? image;


}