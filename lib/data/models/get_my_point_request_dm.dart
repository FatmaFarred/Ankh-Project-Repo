import '../../domain/entities/get_my_point_request_entity.dart';

/// id : "1d131e66-3970-4ecd-bb20-d3e32cc949ef"
/// userId : "9968d643-40af-4e94-b729-d9108150af1f"
/// points : 2
/// description : "مستعجل"
/// status : 2
/// adminNote : "fgh"
/// createdAt : "2025-07-30T00:02:48.4450172"

class GetMyPointRequestDm  extends GetMyPointRequestEntity {
  GetMyPointRequestDm({
    super.id,
    super.userId,
    super.points,
    super.description,
    super.status,
    super.adminNote,
    super.createdAt,});


  GetMyPointRequestDm.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    points = json['points'];
    description = json['description'];
    status = json['status'];
    adminNote = json['adminNote'];
    createdAt = json['createdAt'];
  }



}