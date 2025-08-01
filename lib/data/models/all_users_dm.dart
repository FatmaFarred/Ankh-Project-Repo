import '../../domain/entities/all_users_entity.dart';

/// id : "78caa6c2-cbfc-4ca3-9ae5-cef8da546e97"
/// fullName : "‪Fahmy Hammad‬‏"
/// email : "gg@gmail.com"
/// phoneNumber : "01006747608"
/// code : "MAR-0001"

class AllUsersDm  extends AllUsersEntity {
  AllUsersDm({
      super.id,
    super.fullName,
    super.email,
    super.phoneNumber,
    super.code,});

  AllUsersDm.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    code = json['code'];
  }


}