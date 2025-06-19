import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotification {
  final firebaseMessaging=FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();

  initNotification ()async{
    InitializationSettings settings =InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings()

    );
    flutterLocalNotificationsPlugin.initialize(settings,
    //onDidReceiveBackgroundNotificationResponse: (details){},
    //  onDidReceiveNotificationResponse:  (details){},
    );
}

static void showBasicNotification (RemoteMessage message)async{
  /*final http.Response image = await http.get(Uri.parse(message.notification?.android?.imageUrl??""));
  BigPictureStyleInformation bigPictureStyleInformation =
  BigPictureStyleInformation(
    ByteArrayAndroidBitmap.fromBase64String(base64Encode(image.bodyBytes)),
    largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Encode(image.bodyBytes)),
  );*/
  NotificationDetails details =NotificationDetails(
    android:AndroidNotificationDetails(
        'channel_id',
        'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      //  styleInformation: bigPictureStyleInformation,
      playSound: true,
      //sound: RawResourceAndroidNotificationSound('custom_notification'.split('.').first),

    ),


  );

 await flutterLocalNotificationsPlugin.show(
     0,
     message.notification?.title ,
     message.notification?.body,


     details);

}


}