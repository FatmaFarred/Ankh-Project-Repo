import '../../domain/entities/inspection_report_details_entity.dart';

/// productName : "Toyota EX30\t"
/// clientName : "fady"
/// phoneNumber : "01277154412"
/// address : "اليكس "
/// appointmentDate : "2025-07-22T00:00:00"
/// appointmentTime : "19:48:00"
/// productImages : ["uploads/vehicles/f6b68b72-2390-44a5-b03b-3c373226fd30.jpg"]
/// status : "Completed"
/// inspectionImages : ["uploads/inspection/8d8ce273-a75f-4a51-b70d-caac19f13224.png"]
/// inspectorComment : "تم البيع "

class InspectionReportDetailsDm extends InspectionReportDetailsEntity {
  InspectionReportDetailsDm({
      super.productName,
    super.clientName,
    super.phoneNumber,
    super.address,
    super.appointmentDate,
    super.appointmentTime,
    super.productImages,
    super.status,
    super.inspectionImages,
    super.inspectorComment,});

  InspectionReportDetailsDm.fromJson(dynamic json) {
    productName = json['productName'];
    clientName = json['clientName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    productImages = json['productImages'] != null ? json['productImages'].cast<String>() : [];
    status = json['status'];
    inspectionImages = json['inspectionImages'] != null ? json['inspectionImages'].cast<String>() : [];
    inspectorComment = json['inspectorComment'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = productName;
    map['clientName'] = clientName;
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['appointmentDate'] = appointmentDate;
    map['appointmentTime'] = appointmentTime;
    map['productImages'] = productImages;
    map['status'] = status;
    map['inspectionImages'] = inspectionImages;
    map['inspectorComment'] = inspectorComment;
    return map;
  }

}