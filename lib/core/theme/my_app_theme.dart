
import 'package:flutter/material.dart';

import '../constants/color_manager.dart';
import 'custome_theme/appbar_theme.dart';
import 'custome_theme/bottomsheet_theme.dart' show MyBottomSheetTheme;
import 'custome_theme/checkbox_theme.dart';
import 'custome_theme/chip_theme.dart';
import 'custome_theme/outlined_botton_theme.dart';
import 'my_text_theme.dart';


class MyAppTheme {
  MyAppTheme._();
  static ThemeData lightTheme(BuildContext context) =>ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: ColorManager.lightprimary,
    scaffoldBackgroundColor: ColorManager.white,
    indicatorColor: ColorManager.containerGrey,
    textTheme: MyTextTheme.lightTextTheme(context),
    appBarTheme:MyAppBarTheme.lightAppBarTheme(context),
      bottomSheetTheme:MyBottomSheetTheme.lightBottomSheet,
    checkboxTheme:MyCheckBoxTheme.lightCheckBox,
    chipTheme:MyChipTheme.lightChipTheme(context),
    outlinedButtonTheme:MyOutLinedBottonTheme.lightOutlinedButtonTheme(context)
  );




  static ThemeData darkTheme(BuildContext context) =>ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: ColorManager.darkBlue,
      indicatorColor: ColorManager.containerdarkGrey,

      scaffoldBackgroundColor: ColorManager.black,
      textTheme: MyTextTheme.darkTextTheme(context),
      appBarTheme:MyAppBarTheme.darkAppBarTheme(context),
      bottomSheetTheme:MyBottomSheetTheme.darkBottomSheet,
      checkboxTheme:MyCheckBoxTheme.darkCheckBox,
      chipTheme:MyChipTheme.darkChipTheme(context),
      outlinedButtonTheme:MyOutLinedBottonTheme.darkOutlinedButtonTheme(context)



  );






}