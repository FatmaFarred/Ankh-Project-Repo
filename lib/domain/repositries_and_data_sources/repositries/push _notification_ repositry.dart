import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/notification_entity.dart';

abstract class PushNotificationRepositry{

   Future<void> sendNotificationToAllDevices({
    required List<String> tokens,
    required String title,
    required String body,
  }) ;
   Future <Either<Failure,String?>> postNotification( String userId,String AdminToken, String message ,File? image) ;
    Future<Either<Failure,List<NotificationEntity>>> getNotification(String userId, String token) ;

}