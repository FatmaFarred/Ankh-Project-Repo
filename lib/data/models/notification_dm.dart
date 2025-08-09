import '../../domain/entities/notification_entity.dart';

/// id : 6
/// name : "marketer "
/// message : "Hiii"
/// image_url : null
/// is_read : false
/// created_at : "2025-08-05T02:21:53.2739787"

class NotificationDm extends NotificationEntity {
  NotificationDm({
      super.id,
    super.name,
    super.message,
    super.imageUrl,
    super.isRead,
    super.createdAt,});

  NotificationDm.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    message = json['message'];
    imageUrl = json['image_url'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }


}