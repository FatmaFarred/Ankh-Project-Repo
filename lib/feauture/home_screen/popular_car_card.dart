import 'package:ankh_project/feauture/details_screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

class PopularCarCard extends StatelessWidget {
  const PopularCarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){return DetailsScreen();}));
      },
      child: Container(
        width: 240.w,
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF131313).withOpacity(0.1),
            width: 0.9.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: Image.asset(ImageAssets.carPic1)),

            Row(
              children: [
                Text(
                  "Toyota EX30",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.black,
                  ),
                ),
                Spacer(),
                RatingBarIndicator(
                  rating: 5,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: ColorManager.starRateColor),
                  itemCount: 1,
                  itemSize: 16.sp,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 4.w),
                Text(
                  "5.0",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.hintColor,
                  ),
                ),
              ],
            ),
            Text(
              "Automatic - Electric",
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: ColorManager.hintColor,
              ),
            ),
            Text(
              "EGP 1.9M - 2.3M",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.lightprimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
