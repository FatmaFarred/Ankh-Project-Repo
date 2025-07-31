/// id : "0b7b3d4b-682a-4419-ad52-03430bc9b782"
/// fullName : "karaam "
/// email : "karaam267@gmail.com"
/// phoneNumber : "01277165514"
/// code : null
/// accountStatus : "Pending"

class AllMarketersEntity {
  AllMarketersEntity({
      this.id, 
      this.fullName, 
      this.email, 
      this.phoneNumber, 
      this.code, 
      this.accountStatus,
      this.productsCount,
      this.teamLeader,
      this.role

  });

  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  dynamic code;
  String? accountStatus;
  int? productsCount;
  String? teamLeader;
  String? role;


}