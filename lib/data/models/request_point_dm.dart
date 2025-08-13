import '../../domain/entities/request_point_entitty.dart';

/// id : "9f73c8d7-8026-4525-b3b0-55ba004c6562"
/// userName : "Fahmy Hammad"
/// points : 20
/// roleName : "LeaderMarketer"
/// createdAt : "2025-07-29T19:29:20.5776883"
/// phoneNumber : "01006747608"
/// description : "tt"
/// status : "Pending"

class RequestPointDm extends RequestPointEntity {
  RequestPointDm({
      super.id,
      super.userName,
      super.points,
    super.amount,
      super.roleName,
    super.createdAt,
    super.phoneNumber,
    super.description,
    super.status,});

  RequestPointDm.fromJson(dynamic json) {
    id = json['id'];
    userName = json['userName'];
    points = json['points'];
    roleName = json['roleName'];
    createdAt = json['createdAt'];
    phoneNumber = json['phoneNumber'];
    description = json['description'];
    status = json['status'];
    amount = json['amount'];
  }


}