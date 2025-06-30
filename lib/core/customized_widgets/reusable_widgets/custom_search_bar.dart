import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon:  Icon(Icons.search, color: ColorManager.hintColor),
          hintText: 'What are you looking for?',
          hintStyle:  GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w400,color: ColorManager.hintColor),
          border: InputBorder.none,
          contentPadding:  REdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
