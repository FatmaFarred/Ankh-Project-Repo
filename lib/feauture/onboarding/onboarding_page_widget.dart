import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OnBoardingPageWidget extends StatelessWidget {
  OnBoardingPageWidget({
    required this.text, required this.imagePath, required this.subText
  });
  String imagePath;
  String text;
  String subText;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(height:527.3.h,width:428.w,
        child: Image.asset(imagePath,
        fit: BoxFit.fill,
        ),),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 18.26.h),
        child: Column(children: [
        Text(text,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h,),
        Text(subText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorManager.darkGrey),
          textAlign: TextAlign.center,
        ),

             ]
        ),
      )

    ],);
  }
}