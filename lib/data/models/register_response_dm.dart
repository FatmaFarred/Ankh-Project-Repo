import '../../domain/entities/register_response_entity.dart';

class RegisterResponseDm extends RegisterResponseEntity{

  RegisterResponseDm({super.message, super.token});

  RegisterResponseDm.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }
}