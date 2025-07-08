import '../../domain/entities/marketer_request_inspection_details_entity.dart';

/// id : 4
/// productName : "test2"
/// fuelType : "Petrol"
/// transmission : "Automatic"
/// productImage : "uploads/vehicles/0c84f171-9c6c-447b-83f8-6b89784eb1bc.jpg"
/// clientName : "Mo"
/// phoneNumber : "01006747608"
/// address : "tala"
/// preferredDate : "2025-07-06T00:00:00"
/// preferredTime : "03:00"
/// marketerName : "Fahmy Hammad"
/// inspectorName : "لم يتم التعيين"
/// status : "Pending"

class MarketerRequestInspectionDetailsDm extends MarketerRequestInspectionDetailsEntity {
  MarketerRequestInspectionDetailsDm({
    super.id,
    super.productName,
    super.fuelType,
    super.transmission,
    super.productImage,
    super.clientName,
    super.phoneNumber,
    super.address,
    super.preferredDate,
    super.preferredTime,
    super.marketerName,
    super.inspectorName,
    super.status,
  });

  MarketerRequestInspectionDetailsDm.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    fuelType = json['fuelType'];
    transmission = json['transmission'];
    productImage = json['productImage'];
    clientName = json['clientName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    preferredDate = json['preferredDate'];
    preferredTime = json['preferredTime'];
    marketerName = json['marketerName'];
    inspectorName = json['inspectorName'];
    status = json['status'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productName'] = productName;
    map['fuelType'] = fuelType;
    map['transmission'] = transmission;
    map['productImage'] = productImage;
    map['clientName'] = clientName;
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['preferredDate'] = preferredDate;
    map['preferredTime'] = preferredTime;
    map['marketerName'] = marketerName;
    map['inspectorName'] = inspectorName;
    map['status'] = status;
    return map;
  }

}