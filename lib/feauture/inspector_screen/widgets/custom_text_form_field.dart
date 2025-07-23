// lib/core/customized_widgets/custom_text_form_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final int maxLines;
  final bool enabled;
  final String? initialValue;

  const CustomTextFormField({
    super.key,
    this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled:enabled ,
      initialValue:initialValue ,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.textBlack,fontSize: 14.sp),

      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
        contentPadding: EdgeInsets.all(16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xff777777).withOpacity(0.5),
          ),
        ),
        disabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xff777777).withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xff777777).withOpacity(0.5),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xff777777).withOpacity(0.5),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xff777777).withOpacity(0.5),
          ),

        ),

      ),
    );
  }
}
