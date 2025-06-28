import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/languge_cubit.dart';
import '../color_manager.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(BuildContext context,double fontSize, FontWeight fontWeight, Color color) {
  final locale = context.watch<LanguageCubit>().state;

  return TextStyle(
      fontSize: fontSize,
      fontFamily: locale == const Locale('en')
      ? FontConstants.fontFamily
      :FontConstants.fontFamilyCairo,
  color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color,required BuildContext context}) {
  return _getTextStyle(context,fontSize, FontWeightManager.light, color);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color,required BuildContext context}) {
  return _getTextStyle(context,fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color,required BuildContext context}) {
  return _getTextStyle(context,fontSize, FontWeightManager.medium, color);
}

// bold style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color,required BuildContext context}) {
  return _getTextStyle(context,fontSize, FontWeightManager.bold, color);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color,required BuildContext context}) {
  return _getTextStyle(context,fontSize, FontWeightManager.semiBold, color );
}

TextStyle getTextWithLine() {
  return TextStyle(
    color: ColorManager.lightprimary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.lineThrough,
    decorationColor: ColorManager.lightprimary,
  );
}

