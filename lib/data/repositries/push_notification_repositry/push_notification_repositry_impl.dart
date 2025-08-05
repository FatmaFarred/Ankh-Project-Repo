import 'dart:io';

import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:ankh_project/domain/entities/notification_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositries_and_data_sources/repositries/push _notification_ repositry.dart';
@Injectable(as: PushNotificationRepositry)
class PushNotificationRepositryImpl implements PushNotificationRepositry{
  PushNotificationDataSourse pushNotificationDataSourse ;
  PushNotificationRepositryImpl(this.pushNotificationDataSourse);
  @override
  Future<void> sendNotificationToAllDevices({required List<String> tokens, required String title, required String body})async {
    await pushNotificationDataSourse.sendNotificationToAllDevices(tokens: tokens, title: title, body: body);
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotification(String userId, String token)async {
    var either =await pushNotificationDataSourse.getNotification(userId, token);
    return either.fold((error) => left(error), (response) => right(response));


  }

  @override
  Future<Either<Failure, String?>> postNotification(String userId, String AdminToken, String message, File? image)async {
    var either =await pushNotificationDataSourse.postNotification(userId, AdminToken, message, image);
    return either.fold((error) => left(error), (response) => right(response));

  }

}