import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/product_details_entity.dart';

class StatusSection extends StatelessWidget {
   StatusSection({super.key, required this.product});
  ProductDetailsEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: Color(0xFFF9F9FA),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageIcon(
                AssetImage(ImageAssets.onlineIcon),
                color: Colors.green,
              ),
              Text(
                product?.status??"",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: Color(0xFFF9F9FA),
          ),
          child: Row(
            children: [
              Icon(Icons.remove_red_eye_outlined),
              Text(
                "${product.views} ${ AppLocalizations.of(context)!.views}",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: Color(0xFFF9F9FA),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.verified_outlined,
                color: Colors.green,
                size: 15,
              ),
              Text(
                AppLocalizations.of(context)!.verified,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
