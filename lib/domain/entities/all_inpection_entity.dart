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

class AllInpectionEntity {
  AllInpectionEntity({
      this.id, 
      this.productName, 
      this.productImage, 
      this.marketerName, 
      this.inspectorName, 
      this.clientName, 
      this.phoneNumber, 
      this.preferredDate, 
      this.preferredTime, 
      this.inspectorPoints,
      this.status,
      this.address,
      this.date,
      this.time

  });

  num? id;
  num? inspectorPoints;
  String? productName;
  String? productImage;
  String? marketerName;
  dynamic inspectorName;
  String? clientName;
  String? phoneNumber;
  String? preferredDate;
  String? preferredTime;
  String? status;
 String? address; // only in search result
 String? date;    // search response field
 String? time;



}