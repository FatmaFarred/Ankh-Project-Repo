/// id : 6
/// name : "marketer "
/// message : "Hiii"
/// image_url : null
/// is_read : false
/// created_at : "2025-08-05T02:21:53.2739787"

class NotificationEntity {
  NotificationEntity({
      this.id, 
      this.name, 
      this.message, 
      this.imageUrl, 
      this.isRead, 
      this.createdAt,});

  num? id;
  String? name;
  String? message;
  dynamic imageUrl;
  bool? isRead;
  String? createdAt;


}