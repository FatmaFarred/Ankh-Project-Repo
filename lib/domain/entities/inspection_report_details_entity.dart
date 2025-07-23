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

class InspectionReportDetailsEntity {
  InspectionReportDetailsEntity({
      this.productName, 
      this.clientName, 
      this.phoneNumber, 
      this.address, 
      this.appointmentDate, 
      this.appointmentTime, 
      this.productImages, 
      this.status, 
      this.inspectionImages, 
      this.inspectorComment,});

  String? productName;
  String? clientName;
  String? phoneNumber;
  String? address;
  String? appointmentDate;
  String? appointmentTime;
  List<String>? productImages;
  String? status;
  List<String>? inspectionImages;
  String? inspectorComment;


}