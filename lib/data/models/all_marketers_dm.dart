import '../../domain/entities/all_marketers_entity.dart';

/// id : "0b7b3d4b-682a-4419-ad52-03430bc9b782"
/// fullName : "karaam "
/// email : "karaam267@gmail.com"
/// phoneNumber : "01277165514"
/// code : null
/// accountStatus : "Pending"

class AllMarketersDm extends AllMarketersEntity {
  AllMarketersDm({
      super.id,
    super.fullName,
    super.email,
    super.phoneNumber,
    super.code,
    super.accountStatus,
    super.productsCount,


  });

  AllMarketersDm.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    code = json['code'];
    accountStatus = json['accountStatus'];
    productsCount = json['productsCount'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['code'] = code;
    map['accountStatus'] = accountStatus;
    map['productsCount'] = productsCount;
    return map;
  }

}