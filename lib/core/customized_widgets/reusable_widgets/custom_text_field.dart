import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_manager.dart';
import '../../constants/font_manager/font_style_manager.dart';


typedef MyValidator = String? Function(String?);
typedef OnFieldSubmitted = void Function(String?);

class CustomTextField extends StatelessWidget {
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? hintText;
  bool obscureText;
  MyValidator? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  OnFieldSubmitted? onFieldSubmitted;
  CustomTextField({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onFieldSubmitted,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: getRegularStyle(color: ColorManager.white,context:context ),
      obscureText: obscureText,
      obscuringCharacter: '*',
      cursorColor: ColorManager.darkBlue,
      decoration: InputDecoration(
        errorStyle: getRegularStyle(color: ColorManager.error,context:context ),
        suffixIcon: suffixIcon,
        suffixIconColor: ColorManager.white,
        prefixIcon: prefixIcon,
        prefixIconColor: ColorManager.white,
        hintText: hintText,
        hintStyle: getRegularStyle(color: ColorManager.white,context:context ),
        filled: true,
        fillColor: ColorManager.darkGrey,
        enabledBorder: customOutlineInputBorder(),
        focusedBorder: customOutlineInputBorder(),
        errorBorder: customOutlineInputBorder(),
        focusedErrorBorder: customOutlineInputBorder(),
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  InputBorder customOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide:  BorderSide(
          color: ColorManager.darkGrey,
          width: 2,
        ));
  }
}
