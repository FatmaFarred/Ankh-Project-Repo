import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';

/// id : 2
/// productName : "test"
/// productImage : "uploads/vehicles/73414ef2-4e79-418d-86e8-a2f67310fff8.jpg"
/// marketerName : "Fahmy Hammad"
/// inspectorName : "Fahmy Hammad"
/// clientName : "Fahmy Hammad"
/// phoneNumber : "01006747608"
/// preferredDate : "2025-07-03T00:00:00"
/// preferredTime : "14:30"
/// status : "Done"

class MarketerRequestsForInspectionDm extends MarketerRequestsForInspectionEntity {
  MarketerRequestsForInspectionDm({
    super.id,
    super.productName,
    super.productImage,
    super.marketerName,
    super.inspectorName,
    super.clientName,
    super.phoneNumber,
    super.preferredDate,
    super.preferredTime,
    super.status,
    super.address,
  });

  MarketerRequestsForInspectionDm.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    marketerName = json['marketerName'];
    inspectorName = json['inspectorName'];
    clientName = json['clientName'];
    phoneNumber = json['phoneNumber'];
    preferredDate = json['preferredDate'];
    preferredTime = json['preferredTime'];
    status = json['status'];
    address = json['address'] ;
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['productImage'] = productImage;
    map['marketerName'] = marketerName;
    map['inspectorName'] = inspectorName;
    map['clientName'] = clientName;
    map['phoneNumber'] = phoneNumber;
    map['preferredDate'] = preferredDate;
    map['preferredTime'] = preferredTime;
    map['status'] = status;
    map['address'] = address;
    return map;
  }

}