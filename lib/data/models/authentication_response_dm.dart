import '../../domain/entities/authentication_response_entity.dart';

/// message : "تم تسجيل المسوق بنجاح"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImI4NTZjMTdjLWZlODMtNDhlMi1hZmMxLWNkNTk1MjYwODE2MyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJmYXRtYTIyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiZmF0bWEyMkBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJNYXJrZXRlciIsImV4cCI6MTc1MjA2NTM5MiwiaXNzIjoiQW5raEF1dGhTZXJ2ZXIiLCJhdWQiOiJBbmtoQXBpVXNlcnMifQ.tiTGiI8kOnd2FB2Ycg1WuCfzFCpyczn-6YOigbnXTZQ"
/// user : {"id":"b856c17c-fe83-48e2-afc1-cd5952608163","fullName":"fatma","email":"fatma22@gmail.com","roles":["Marketer"],"phoneNumber":"0277185514","deviceTokens":["3eff0093-ab81-4dd9-be77-eb0dd0c7968s"]}

class AuthenticationResponseDm extends AuthenticationResponseEntity {
  AuthenticationResponseDm({
      super.message,
      super.token,
      super.user,});

  AuthenticationResponseDm.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? UserDm.fromJson(json['user']) : null;
  }



}

/// id : "b856c17c-fe83-48e2-afc1-cd5952608163"
/// fullName : "fatma"
/// email : "fatma22@gmail.com"
/// roles : ["Marketer"]
/// phoneNumber : "0277185514"
/// deviceTokens : ["3eff0093-ab81-4dd9-be77-eb0dd0c7968s"]

class UserDm extends UserEntity {
  UserDm({
      super.id,
      super.fullName,
    super.email,
    super.roles,
    super.phoneNumber,
    super.deviceTokens,});

  UserDm.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    phoneNumber = json['phoneNumber'];
    deviceTokens = json['deviceTokens'] != null ? json['deviceTokens'].cast<String>() : [];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['email'] = email;
    map['roles'] = roles;
    map['phoneNumber'] = phoneNumber;
    map['deviceTokens'] = deviceTokens;
    return map;
  }

}