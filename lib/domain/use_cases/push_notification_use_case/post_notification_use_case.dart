import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../repositries_and_data_sources/repositries/push _notification_ repositry.dart';
@injectable
class PostNotificationUseCase{
  PushNotificationRepositry pushNotificationRepositry;
  PostNotificationUseCase(this.pushNotificationRepositry);

  Future <Either<Failure,String?>> execute(String userId,String AdminToken, String message ,File? image)async{
   return await pushNotificationRepositry.postNotification(userId, AdminToken, message, image);
  }
}