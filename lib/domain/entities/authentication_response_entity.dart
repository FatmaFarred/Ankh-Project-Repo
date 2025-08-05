/// message : "تم تسجيل المسوق بنجاح"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImI4NTZjMTdjLWZlODMtNDhlMi1hZmMxLWNkNTk1MjYwODE2MyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJmYXRtYTIyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiZmF0bWEyMkBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJNYXJrZXRlciIsImV4cCI6MTc1MjA2NTM5MiwiaXNzIjoiQW5raEF1dGhTZXJ2ZXIiLCJhdWQiOiJBbmtoQXBpVXNlcnMifQ.tiTGiI8kOnd2FB2Ycg1WuCfzFCpyczn-6YOigbnXTZQ"
/// user : {"id":"b856c17c-fe83-48e2-afc1-cd5952608163","fullName":"fatma","email":"fatma22@gmail.com","roles":["Marketer"],"phoneNumber":"0277185514","deviceTokens":["3eff0093-ab81-4dd9-be77-eb0dd0c7968s"]}

class AuthenticationResponseEntity {
  AuthenticationResponseEntity({
      this.message, 
      this.token, 
      this.user,});

  String? message;
  String? token;
  UserEntity? user;


}

/// id : "b856c17c-fe83-48e2-afc1-cd5952608163"
/// fullName : "fatma"
/// email : "fatma22@gmail.com"
/// roles : ["Marketer"]
/// phoneNumber : "0277185514"
/// deviceTokens : ["3eff0093-ab81-4dd9-be77-eb0dd0c7968s"]

class UserEntity {
  UserEntity({
      this.id, 
      this.fullName, 
      this.email, 
      this.roles, 
      this.phoneNumber, 
      this.deviceTokens,
      this.teamLeaderId,});


  String? id;
  String? fullName;
  String? email;
  List<String>? roles;
  String? phoneNumber;
  List<String>? deviceTokens;
  String? teamLeaderId; // Assuming teamLeaderId is part of UserEntity


}