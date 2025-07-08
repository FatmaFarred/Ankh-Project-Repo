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

class MarketerRequestInspectionDetailsEntity {
  MarketerRequestInspectionDetailsEntity({
      this.id, 
      this.productName, 
      this.fuelType, 
      this.transmission, 
      this.productImage, 
      this.clientName, 
      this.phoneNumber, 
      this.address, 
      this.preferredDate, 
      this.preferredTime, 
      this.marketerName, 
      this.inspectorName, 
      this.status,});

  num? id;
  String? productName;
  String? fuelType;
  String? transmission;
  String? productImage;
  String? clientName;
  String? phoneNumber;
  String? address;
  String? preferredDate;
  String? preferredTime;
  String? marketerName;
  String? inspectorName;
  String? status;


}