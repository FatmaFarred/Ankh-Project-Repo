import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';
import '../../constants/font_manager/font_style_manager.dart';

class MyChipTheme {
  MyChipTheme._();
  
  static ChipThemeData lightChipTheme (BuildContext context) =>ChipThemeData (
    disabledColor: ColorManager.darkGrey.withOpacity(0.4),
    selectedColor: ColorManager.darkBlue,
    checkmarkColor: ColorManager.white,
    labelStyle: getRegularStyle(color: ColorManager.black,context:context),
    padding: EdgeInsets.symmetric(vertical: 12,horizontal:12 )
  );


  static ChipThemeData darkChipTheme (BuildContext context) =>ChipThemeData (
      disabledColor: ColorManager.darkGrey.withOpacity(0.4),
      selectedColor: ColorManager.darkBlue,
      checkmarkColor: ColorManager.white,
      labelStyle: getRegularStyle(color: ColorManager.white,context:context),
      padding: EdgeInsets.symmetric(vertical: 12,horizontal:12 )
  );
  
}