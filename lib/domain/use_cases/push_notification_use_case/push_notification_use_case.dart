import 'package:injectable/injectable.dart';

import '../../repositries_and_data_sources/repositries/push _notification_ repositry.dart';
@injectable
class PushNotificationUseCase{
  PushNotificationRepositry pushNotificationRepositry;
  PushNotificationUseCase(this.pushNotificationRepositry);
  Future<void> pushNotificationToAllDevices({
    required List<String> tokens,
    required String title,
    required String body,}
      )async{
    await pushNotificationRepositry.sendNotificationToAllDevices(tokens:tokens, title: title, body: body);
  }
}