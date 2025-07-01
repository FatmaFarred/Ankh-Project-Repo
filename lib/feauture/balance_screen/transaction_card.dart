import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 13),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              padding: REdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all(
                  width: 0.8.w,
                  color: ColorManager.hintColor
              ),borderRadius: BorderRadius.circular(12.r)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toyota EX30",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "10 Dec 2025 at 14:00 Pm",
                        style: GoogleFonts.manrope(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.hintColor
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EGP 5000",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.black
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Color(0xFFFEF9C3)
                        ),
                        child: Text(
                          "Pending",
                          style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF166534)
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context,index){return SizedBox(height: 8.h,) ;},
          itemCount: 6,
        ),
      ),
    );
  }
}
