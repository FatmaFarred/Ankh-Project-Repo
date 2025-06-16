import 'package:flutter/material.dart';

import '../constants/color_manager.dart';
import '../constants/font_manager/font_style_manager.dart';

class MyTextTheme {
  MyTextTheme._();

  static TextTheme lightTextTheme=TextTheme(
    headlineLarge: getBoldStyle(color: ColorManager.black,fontSize: 24),
    headlineMedium: getSemiBoldStyle(color: ColorManager.black,fontSize: 22),
    headlineSmall: getMediumStyle(color: ColorManager.black,fontSize: 20),
    titleLarge:getBoldStyle(color: ColorManager.black,fontSize: 18),
    titleMedium:getSemiBoldStyle(color: ColorManager.black,fontSize: 18) ,
    titleSmall: getMediumStyle(color: ColorManager.black,fontSize: 18),
    bodyLarge: getBoldStyle(color: ColorManager.black,fontSize: 14),
    bodyMedium: getMediumStyle(color: ColorManager.black,fontSize: 14),
    bodySmall:getRegularStyle(color:ColorManager.black,fontSize: 14) ,
    labelLarge: getMediumStyle(color: ColorManager.black,fontSize: 12),
    labelMedium:getRegularStyle(color:ColorManager.black,fontSize: 12) ,
    labelSmall: getLightStyle(color:ColorManager.black,fontSize: 12),





  );



  static TextTheme darkTextTheme=TextTheme(
    headlineLarge: getBoldStyle(color: ColorManager.white,fontSize: 24),
    headlineMedium: getSemiBoldStyle(color: ColorManager.white,fontSize: 22),
    headlineSmall: getMediumStyle(color: ColorManager.white,fontSize: 20),
    titleLarge:getBoldStyle(color: ColorManager.white,fontSize: 18),
    titleMedium:getSemiBoldStyle(color: ColorManager.white,fontSize: 18) ,
    titleSmall: getMediumStyle(color: ColorManager.white,fontSize: 18),
    bodyLarge: getBoldStyle(color: ColorManager.white,fontSize: 14),
    bodyMedium: getMediumStyle(color: ColorManager.white,fontSize: 14),
    bodySmall:getRegularStyle(color:ColorManager.white,fontSize: 14) ,
    labelLarge: getMediumStyle(color: ColorManager.white,fontSize: 12),
    labelMedium:getRegularStyle(color:ColorManager.white,fontSize: 12) ,
    labelSmall: getLightStyle(color:ColorManager.white,fontSize: 12),



  );




}