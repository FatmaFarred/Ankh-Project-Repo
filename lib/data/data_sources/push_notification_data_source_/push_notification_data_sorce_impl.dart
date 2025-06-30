import 'package:injectable/injectable.dart';

import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart';
import '../../../firebase_service/notification_service/local notification.dart';
import '../../../firebase_service/notification_service/push notification_manager.dart';
@Injectable(as: PushNotificationDataSourse)
class PushNotificationDataSourseImpl implements PushNotificationDataSourse{
  FirebaseMessagingService firebaseMessagingService;

  PushNotificationDataSourseImpl(this.firebaseMessagingService);


  @override
  Future<void> sendNotificationToAllDevices({required List<String> tokens, required String title, required String body})async {
    try{
      for (final token in tokens) {
        await firebaseMessagingService.sendNotification(targetFcmToken: token, title: title, body: body);
      }
    }catch(e){
      print(e.toString());


    }
  }

}