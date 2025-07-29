import '../../domain/entities/all_inspectors_entity.dart';

/// id : "1502f647-31f3-4884-baaa-4635a80584df"
/// fullName : "Fatma farred"
/// email : "Fatmafarred287@gmail.com"
/// phoneNumber : "01288145513"
/// code : ""
/// totalInspections : 0
/// completedInspections : 0

class AllInspectorsDm  extends AllInspectorsEntity {
  AllInspectorsDm({
      super.id,
      super.fullName,
      super.email,
      super.phoneNumber,
      super.code,
      super.totalInspections,
      super.completedInspections,
    super.accountStatus


  });

  AllInspectorsDm.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    code = json['code'];
    totalInspections = json['totalInspections'];
    completedInspections = json['completedInspections'];
    accountStatus = json['accountStatus'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['code'] = code;
    map['totalInspections'] = totalInspections;
    map['completedInspections'] = completedInspections;
    map['accountStatus'] = accountStatus;
    return map;
  }

}