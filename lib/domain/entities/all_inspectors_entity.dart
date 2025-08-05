/// id : "1502f647-31f3-4884-baaa-4635a80584df"
/// fullName : "Fatma farred"
/// email : "Fatmafarred287@gmail.com"
/// phoneNumber : "01288145513"
/// code : ""
/// totalInspections : 0
/// completedInspections : 0

class AllInspectorsEntity {
  AllInspectorsEntity({
      this.id, 
      this.fullName, 
      this.email, 
      this.phoneNumber, 
      this.code, 
      this.totalInspections, 
      this.completedInspections,
      this.vehicleType,
      this.licenseNumber,
      this.licenseImage,
      this.vehicleLicenseNumber,
      this.vehicleImage,
      this.workArea,
      this.deviceTokens,



  });

  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? code;
  num? totalInspections;
  num? completedInspections;
  String? vehicleType;
  String? licenseNumber;
  String? licenseImage;
  String? vehicleLicenseNumber;
  String? vehicleImage;
  String? workArea;
  List<String>? deviceTokens;




}