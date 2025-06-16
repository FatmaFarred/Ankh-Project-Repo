import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDeviceUtility {

  static void hideKeyBoard (BuildContext context ){
  FocusScope.of(context).requestFocus(FocusNode());


  }

  static Future<void > setStatusBarColor (Color color)async{
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: color));

  }

  static bool isLandScapeOrientation (BuildContext context ){
    final viewInsets= View.of(context).viewInsets;
    return viewInsets.bottom==0;

  }

  static bool isPortraitOrientation (BuildContext context ) {
    final viewInsets = View
        .of(context)
        .viewInsets;
    return viewInsets.bottom != 0;
  }

  static void setFullScreeen (bool enable ){
    SystemChrome.setEnabledSystemUIMode(enable? SystemUiMode.immersiveSticky: SystemUiMode.edgeToEdge);

  }

  static double getScreenWidth (BuildContext context ){
    return MediaQuery.of(context).size.width;
  }
  static double getScreenHeight (BuildContext context ){
    return MediaQuery.of(context).size.height;
  }
  static double getPixelRatio (BuildContext context ){
    return MediaQuery.of(context).devicePixelRatio;
  }
  static double getScreenBarHeight (BuildContext context ){
    return MediaQuery.of(context).padding.top;
  }
  static double getBottmNavigationBarHeight ( ){
    return kBottomNavigationBarHeight;
  }
  static double getAppBarHeight ( ){
    return kToolbarHeight;
  }
  static double getKeyBoardHeight ( BuildContext context ){
    final viewInsets= MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }


static Future<bool> isKeyBoardVisible(BuildContext context) async {
  final viewInsets= MediaQuery.of(context).viewInsets;
  return viewInsets.bottom>0 ;

}

  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform==TargetPlatform.android||defaultTargetPlatform==TargetPlatform.iOS;

  }
 static void vibrate (Duration duration){
    HapticFeedback.vibrate();
     Future.delayed(duration,()=>HapticFeedback.vibrate());

 }

  static Future<void> setPreferredOreintation(List<DeviceOrientation>orientations) async {
   await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar ( ){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  }

  static void showStatusBar ( ){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

  }
  static Future <bool> hasInternetConnetion ()async{
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;

    }on SocketException catch(_){
      return false;
    }

  }

 static bool isIos (){
    return Platform.isIOS;
 }
  static bool isAndroid (){
    return Platform.isAndroid;
  }


  }























