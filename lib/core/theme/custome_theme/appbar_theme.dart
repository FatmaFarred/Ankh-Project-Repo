import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';
import '../../constants/font_manager/font_style_manager.dart';

class MyAppBarTheme {
  MyAppBarTheme._();
  static AppBarTheme lightAppBarTheme (BuildContext context) =>AppBarTheme(
   elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,

    backgroundColor: ColorManager.lightprimary,
    surfaceTintColor: ColorManager.transparent,
    iconTheme: IconThemeData(color:ColorManager.white,size: 24 ),
    actionsIconTheme: IconThemeData(color:ColorManager.black,size: 24),

    titleTextStyle: getBoldStyle(color: ColorManager.white,fontSize:20,context:context )


  );


  static AppBarTheme darkAppBarTheme (BuildContext context) =>AppBarTheme(
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: ColorManager.lightprimary,
      surfaceTintColor: ColorManager.transparent,
      iconTheme: IconThemeData(color:ColorManager.black,size: 24 ),
      actionsIconTheme: IconThemeData(color:ColorManager.white,size: 24),
      titleTextStyle: getBoldStyle(color: ColorManager.white,fontSize:20 ,context:context)


  );




}