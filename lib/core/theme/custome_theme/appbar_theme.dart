import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';
import '../../constants/font_manager/font_style_manager.dart';

class MyAppBarTheme {
  MyAppBarTheme._();
  static AppBarTheme lightAppBarTheme (BuildContext context) =>AppBarTheme(
   elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: ColorManager.transparent,
    surfaceTintColor: ColorManager.transparent,
    iconTheme: IconThemeData(color:ColorManager.black,size: 24 ),
    actionsIconTheme: IconThemeData(color:ColorManager.black,size: 24),
    titleTextStyle: getBoldStyle(color: ColorManager.black,fontSize:18,context:context )


  );


  static AppBarTheme darkAppBarTheme (BuildContext context) =>AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: ColorManager.transparent,
      surfaceTintColor: ColorManager.transparent,
      iconTheme: IconThemeData(color:ColorManager.white,size: 24 ),
      actionsIconTheme: IconThemeData(color:ColorManager.white,size: 24),
      titleTextStyle: getBoldStyle(color: ColorManager.white,fontSize:18 ,context:context)


  );




}