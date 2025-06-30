import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart';
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

}