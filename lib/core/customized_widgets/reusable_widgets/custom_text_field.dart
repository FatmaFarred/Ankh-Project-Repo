import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_manager.dart';

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
  VoidCallback? onTap;
  bool? readOnly;
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
    this.onTap,
    this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: Theme.of(context).textTheme.bodySmall,
      obscureText: obscureText,
      obscuringCharacter: '*',
      onTap: onTap,
      readOnly: readOnly??false,
      cursorColor: ColorManager.black,
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorManager.error),
        suffixIcon: suffixIcon,
        suffixIconColor: ColorManager.white,
        prefixIcon: prefixIcon,
        prefixIconColor: Theme.of(context).indicatorColor,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorManager.darkGrey),
        filled: true,
        fillColor: ColorManager.transparent,
        enabledBorder: customOutlineInputBorder(),
        focusedBorder: customOutlineInputBorder(),
        errorBorder: customOutlineErrorInputBorder(),
        focusedErrorBorder: customOutlineInputBorder(),
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  InputBorder customOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide:  BorderSide(
          color: ColorManager.lightGrey,
          width: 2,
        ));
  }
  InputBorder customOutlineErrorInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide:  BorderSide(
          color: ColorManager.error,
          width: 2,
        ));
  }
}