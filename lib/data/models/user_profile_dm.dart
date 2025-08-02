import '../../domain/entities/user_profile_entity.dart';

/// id : "897bd6ba-079d-4882-8e32-53bbe12cd114"
/// fullName : "Fahmy"
/// imageUrl : "/uploads/default-user.png"
/// rating : 0
/// completedTasks : 2

class UserProfileDm  extends UserProfileEntity{
  UserProfileDm({
      super.id,
    super.fullName,
    super.email,
    super.phone,
    super.address,
    super.imageUrl,
    super.rating,
    super.completedTasks,});

  UserProfileDm.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    imageUrl = json['imageUrl'];
    rating = json['rating'];
    completedTasks = json['completedTasks'];
  }


}