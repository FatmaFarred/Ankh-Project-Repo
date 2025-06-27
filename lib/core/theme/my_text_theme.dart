import 'package:flutter/material.dart';

import '../constants/color_manager.dart';
import '../constants/font_manager/font_style_manager.dart';

class MyTextTheme {
  MyTextTheme._();

  static TextTheme lightTextTheme(BuildContext context) =>TextTheme(
    headlineLarge: getBoldStyle(color: ColorManager.black,fontSize: 24,context:context ),
    headlineMedium: getSemiBoldStyle(color: ColorManager.black,fontSize: 22,context:context),
    headlineSmall: getMediumStyle(color: ColorManager.black,fontSize: 20,context:context),
    titleLarge:getBoldStyle(color: ColorManager.black,fontSize: 18,context:context),
    titleMedium:getSemiBoldStyle(color: ColorManager.black,fontSize: 18,context:context) ,
    titleSmall: getMediumStyle(color: ColorManager.black,fontSize: 18,context:context),
    bodyLarge: getBoldStyle(color: ColorManager.black,fontSize: 14,context:context),
    bodyMedium: getMediumStyle(color: ColorManager.black,fontSize: 14,context:context),
    bodySmall:getRegularStyle(color:ColorManager.black,fontSize: 14,context:context) ,
    labelLarge: getMediumStyle(color: ColorManager.black,fontSize: 12,context:context),
    labelMedium:getRegularStyle(color:ColorManager.black,fontSize: 12,context:context) ,
    labelSmall: getLightStyle(color:ColorManager.black,fontSize: 12,context:context),





  );



  static TextTheme darkTextTheme(BuildContext context) =>TextTheme(
    headlineLarge: getBoldStyle(color: ColorManager.white,fontSize: 24,context:context),
    headlineMedium: getSemiBoldStyle(color: ColorManager.white,fontSize: 22,context:context),
    headlineSmall: getMediumStyle(color: ColorManager.white,fontSize: 20,context:context),
    titleLarge:getBoldStyle(color: ColorManager.white,fontSize: 18,context:context),
    titleMedium:getSemiBoldStyle(color: ColorManager.white,fontSize: 18,context:context) ,
    titleSmall: getMediumStyle(color: ColorManager.white,fontSize: 18,context:context),
    bodyLarge: getBoldStyle(color: ColorManager.white,fontSize: 14,context:context),
    bodyMedium: getMediumStyle(color: ColorManager.white,fontSize: 14,context:context),
    bodySmall:getRegularStyle(color:ColorManager.white,fontSize: 14,context:context) ,
    labelLarge: getMediumStyle(color: ColorManager.white,fontSize: 12,context:context),
    labelMedium:getRegularStyle(color:ColorManager.white,fontSize: 12,context:context) ,
    labelSmall: getLightStyle(color:ColorManager.white,fontSize: 12,context:context),



  );




}