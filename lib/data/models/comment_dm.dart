import '../../domain/entities/comment_entity.dart';

/// id : 2
/// content : "منتج ممتاز جدًا ومريح في الاستخدام"
/// userName : "fares"
/// createdAt : "2025-08-02T20:37:28.8398191"

class CommentDm extends CommentEntity {
  CommentDm({
      super.id,
    super.content,
    super.userName,
    super.createdAt,});

  CommentDm.fromJson(dynamic json) {
    id = json['id'];
    content = json['content'];
    userName = json['userName'];
    createdAt = json['createdAt'];
  }


}