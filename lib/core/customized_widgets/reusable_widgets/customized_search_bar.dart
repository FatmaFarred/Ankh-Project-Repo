import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

typedef OnSearchCallback = void Function(String keyword);

class CustomizedSearchBar extends StatelessWidget {
  final OnSearchCallback? onSearch;
  const CustomizedSearchBar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextFormField(
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: ColorManager.textColor,
        ),
        decoration: InputDecoration(
          prefixIcon:  Icon(Icons.search, color: ColorManager.hintColor),
          hintText: AppLocalizations.of(context)!.whatAreYouLookingFor,
          hintStyle:  GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w400,color: ColorManager.hintColor),
          border: InputBorder.none,
          contentPadding:  REdgeInsets.symmetric(vertical: 14),

        ),
        onFieldSubmitted: (value) {
          if (onSearch != null) {
            onSearch!(value.trim());
          }
        },
        onChanged: (value) {
          if (onSearch != null) {
            onSearch!(value.trim());
          }
        },
      ),
    );
  }
}
