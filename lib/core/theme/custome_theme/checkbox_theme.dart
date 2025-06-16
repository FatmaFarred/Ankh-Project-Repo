import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';

class MyCheckBoxTheme {

  MyCheckBoxTheme._();
  static CheckboxThemeData lightCheckBox = CheckboxThemeData (
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4) ),
    checkColor: MaterialStateProperty.resolveWith((states){
      if(states.contains(MaterialState.selected)){
        return ColorManager.white;

      }else {
        return ColorManager.black;
      }

    }
),
    fillColor: MaterialStateProperty. resolveWith((states){
      if(states.contains(MaterialState.selected)){
        return ColorManager.darkBlue;

      }else {
        return ColorManager.transparent;
      }

    }
    ),

  );


  static CheckboxThemeData darkCheckBox = CheckboxThemeData (
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4) ),
    checkColor: WidgetStateProperty.resolveWith((states){
      if(states.contains(WidgetState.selected)){
        return ColorManager.white;

      }else {
        return ColorManager.black;
      }

    }
    ),
    fillColor: WidgetStateProperty. resolveWith((states){
      if(states.contains(WidgetState.selected)){
        return ColorManager.darkBlue;

      }else {
        return ColorManager.transparent;
      }

    }
    ),

  );






}