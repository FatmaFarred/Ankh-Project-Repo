/// id : "9f73c8d7-8026-4525-b3b0-55ba004c6562"
/// userName : "Fahmy Hammad"
/// points : 20
/// roleName : "LeaderMarketer"
/// createdAt : "2025-07-29T19:29:20.5776883"
/// phoneNumber : "01006747608"
/// description : "tt"
/// status : "Pending"

class RequestPointEntity {
  RequestPointEntity({
      this.id, 
      this.userName, 
      this.points,
      this.amount,
      this.roleName, 
      this.createdAt, 
      this.phoneNumber, 
      this.description, 
      this.status,});

  String? id;
  String? userName;
  num? points;
  num? amount;

  String? roleName;
  String? createdAt;
  String? phoneNumber;
  String? description;
  String? status;


}