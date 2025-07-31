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
    super.vehicleType,
    super.licenseNumber,
    super.licenseImage,
    super.vehicleLicenseNumber,
    super.vehicleImage,
    super.workArea,


  });

  AllInspectorsDm.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    code = json['code'];
    totalInspections = json['totalInspections'];
    completedInspections = json['completedInspections'];
    vehicleType = json['vehicleType'];
    licenseNumber = json['licenseNumber'];
    licenseImage = json['licenseImage'];
    vehicleLicenseNumber = json['vehicleLicenseNumber'];
    vehicleImage = json['vehicleImage'];
    workArea = json['workArea'];

  }


}