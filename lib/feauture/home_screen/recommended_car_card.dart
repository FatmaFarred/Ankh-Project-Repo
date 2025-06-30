import 'package:ankh_project/feauture/details_screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

class RecommendedCarCard extends StatelessWidget {
  const RecommendedCarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){return DetailsScreen();}));

      },
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: 0.9.w,
            color: const Color(0xFF131313).withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Image.asset(ImageAssets.carPic1)),
            SizedBox(width: 13.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Toyota EX30",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.black,
                      )),
                  SizedBox(height: 13.h,),

                  Text("Automatic - Electric",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.hintColor,
                      )),
                  SizedBox(height: 13.h,),

                  Text("Price",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.darkGrey,
                      )),
                  Text("EGP 1.9M - 2.3M",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.lightprimary,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
