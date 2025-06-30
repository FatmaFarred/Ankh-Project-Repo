import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(22),
      width: double.infinity,
      decoration: BoxDecoration(color: ColorManager.lightprimary),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(child: Image.asset(ImageAssets.profilePic, scale: 1.2)),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Alexander Hipp",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )),
                    RatingBarIndicator(
                      rating: 5,
                      itemBuilder: (context, _) => const Icon(Icons.star, color: ColorManager.starRateColor),
                      itemCount: 5,
                      itemSize: 12.sp,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(ImageAssets.goldMedal, scale: 6.sp),
                SizedBox(width: 12.w),
                ClipRRect(child: Image.asset(ImageAssets.notification, scale: 1.3)),
              ],
            ),
            SizedBox(height: 24.h),
            const CustomSearchBar()
          ],
        ),
      ),
    );
  }
}
