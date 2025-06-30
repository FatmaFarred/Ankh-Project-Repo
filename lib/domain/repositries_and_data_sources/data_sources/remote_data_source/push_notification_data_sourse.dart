abstract class PushNotificationDataSourse{

  Future<void> sendNotificationToAllDevices({
    required List<String> tokens,
    required String title,
    required String body,
  }) ;

}