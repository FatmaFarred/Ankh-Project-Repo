import '../../domain/entities/cs_roles_response_entity.dart';

/// id : "0f1c8b49-a197-4d5b-90dc-e15f00121f6f"
/// name : "Marketer"
/// description : "مسوق للسيارات"
/// imageUrl : "/uploads/roles/markerterIcon.png"

class CsRolesResponseDm  extends CsRolesResponseEntity{
  CsRolesResponseDm({
      super.id,
    super.name,
    super.description,
    super.imageUrl,});

  CsRolesResponseDm.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    return map;
  }

}