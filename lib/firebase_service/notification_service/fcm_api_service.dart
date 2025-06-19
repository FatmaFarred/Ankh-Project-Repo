  import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'local notification.dart';

  class FcmApi {

  final firebaseMessaging=FirebaseMessaging.instance;

  initNotification ()async{
    await firebaseMessaging.requestPermission();
    final fcmToken=await firebaseMessaging.getToken();
    print (fcmToken);
    FirebaseMessaging.onBackgroundMessage(handleBackGround);
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      LocalNotification.showBasicNotification(message);
     /* firebaseMessaging.subscribeToTopic('all').then((val){
        print("subscribed");
      });*/

    });
  }

  }
  @pragma('vm:entry-point')
  Future<void > handleBackGround (RemoteMessage message)async{
    print ("title :${message.notification?.title}");
    print ("title :${message.notification?.body}");


  }
