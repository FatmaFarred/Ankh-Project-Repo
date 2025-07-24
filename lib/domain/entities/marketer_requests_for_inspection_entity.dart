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

class MarketerRequestsForInspectionEntity {
  MarketerRequestsForInspectionEntity({
      this.id, 
      this.productName, 
      this.productImage, 
      this.marketerName, 
      this.inspectorName, 
      this.clientName, 
      this.phoneNumber, 
      this.preferredDate, 
      this.preferredTime, 
      this.status,
    this.address

  });

  num? id;
  String? productName;
  String? productImage;
  String? marketerName;
  String? inspectorName;
  String? clientName;
  String? phoneNumber;
  String? preferredDate;
  String? preferredTime;
  String? status;
  String? address;


}