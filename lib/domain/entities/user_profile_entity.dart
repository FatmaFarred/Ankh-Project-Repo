/// id : "897bd6ba-079d-4882-8e32-53bbe12cd114"
/// fullName : "Fahmy"
/// email : "user@example.com"
/// phone : "+1234567890"
/// address : "123 Main St"
/// imageUrl : "/uploads/default-user.png"
/// rating : 0
/// completedTasks : 2

class UserProfileEntity {
  UserProfileEntity({
      this.id, 
      this.fullName, 
      this.email,
      this.phone,
      this.address,
      this.imageUrl, 
      this.rating, 
      this.completedTasks,});

  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? imageUrl;
  num? rating;
  num? completedTasks;


}