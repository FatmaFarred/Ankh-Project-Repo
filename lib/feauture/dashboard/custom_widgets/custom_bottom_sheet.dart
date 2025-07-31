import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final String cancelText;
  final String confirmText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final Color? confirmColor;
  final Widget? icon;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    required this.onConfirm,
    this.confirmColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: ColorManager.error.withOpacity(0.1),
                  radius: 30,
                  child: CircleAvatar(
                      backgroundColor: ColorManager.error.withOpacity(0.2),
                      child: icon!),
                ),
                IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close,size: 24.sp,color: ColorManager.darkGrey,))
              ],
            ),
            SizedBox(height: 8.h,),
            Text(title, style: Theme.of(context).textTheme.headlineLarge

            ?.copyWith(fontSize: 18.sp, color: ColorManager.error)),
             SizedBox(height: 8.h),
            Text(description,

            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: ColorManager.darkGrey,
              ),
            ),
             SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: CustomizedElevatedButton(
                  bottonWidget:Text(cancelText,
                    style: Theme.of(context).textTheme.bodyLarge! .copyWith(fontSize: 16.sp),

                  ) ,
                   onPressed: onCancel,
                    borderColor: ColorManager.lightGrey,
                    color: ColorManager.white,

                    ),


                  ),

                 SizedBox(width: 12.w),
                Expanded(
                  child: CustomizedElevatedButton(
                    bottonWidget:Text(confirmText,
                      style: Theme.of(context).textTheme.bodyLarge! .copyWith(fontSize: 16.sp,color:  ColorManager.white),

                    ) ,
                    onPressed: onConfirm,
                    borderColor:confirmColor,
                    color: confirmColor,

                  ),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 