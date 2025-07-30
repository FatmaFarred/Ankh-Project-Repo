/// id : "1d131e66-3970-4ecd-bb20-d3e32cc949ef"
/// userId : "9968d643-40af-4e94-b729-d9108150af1f"
/// points : 2
/// description : "مستعجل"
/// status : 2
/// adminNote : "fgh"
/// createdAt : "2025-07-30T00:02:48.4450172"

class GetMyPointRequestEntity {
  GetMyPointRequestEntity({
      this.id, 
      this.userId, 
      this.points, 
      this.description, 
      this.status, 
      this.adminNote, 
      this.createdAt,});

  String? id;
  String? userId;
  num? points;
  String? description;
  num? status;
  String? adminNote;
  String? createdAt;


}