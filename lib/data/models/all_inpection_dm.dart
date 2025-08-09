import '../../domain/entities/all_inpection_entity.dart';

/// id : 4
/// productName : "test2"
/// productImage : "uploads/vehicles/0c84f171-9c6c-447b-83f8-6b89784eb1bc.jpg"
/// marketerName : "Fahmy Hammad"
/// inspectorName : null
/// clientName : "Mo"
/// phoneNumber : "01006747608"
/// preferredDate : "2025-07-06T12:59:48.035"
/// preferredTime : "03:00"
/// status : "Pending"

class AllInpectionDm extends AllInpectionEntity {
  AllInpectionDm({
      super.id,
    super.productName,
    super.productImage,
    super.marketerName,
    super.inspectorName,
    super.clientName,
    super.phoneNumber,
    super.preferredDate,
    super.preferredTime,
    super.inspectorPoints,
    super.status,
    super.address,
    super.date,
    super.time,

  });

  AllInpectionDm.fromJson(dynamic json) {
    id = json['id'];
    productName = json['productName'];
    productImage = json['productImage'];
    marketerName = json['marketerName'];
    inspectorName = json['inspectorName'];
    inspectorPoints = json['inspectorPoints'];
    clientName = json['clientName'];
    phoneNumber = json['phoneNumber'];
    preferredDate = json['preferredDate'];
    preferredTime = json['preferredTime'];
    status = json['status'];
    address = json['address'];
    date = json['date'];
    time = json['time'];


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
    map['date'] = date;
    map['time'] = time;
    return map;
  }

}