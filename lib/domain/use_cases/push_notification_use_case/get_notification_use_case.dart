import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/notification_entity.dart';
import '../../repositries_and_data_sources/repositries/push _notification_ repositry.dart';
@injectable
class GetNotificationUseCase{
  PushNotificationRepositry pushNotificationRepositry;
  GetNotificationUseCase(this.pushNotificationRepositry);

  Future<Either<Failure,List<NotificationEntity>>>execute(String userId,String token)async{
    return await pushNotificationRepositry.getNotification(userId, token);
  }
}