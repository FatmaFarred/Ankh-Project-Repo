import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';

class MyBottomSheetTheme {
  MyBottomSheetTheme._();
  static BottomSheetThemeData lightBottomSheet = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: ColorManager.white,
    modalBackgroundColor: ColorManager.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))

  );



  static BottomSheetThemeData darkBottomSheet = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: ColorManager.black,
      modalBackgroundColor: ColorManager.black,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))

  );



}