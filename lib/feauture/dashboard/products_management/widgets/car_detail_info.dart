import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailInfo extends StatelessWidget {
  const CarDetailInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Owner Name",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "Mohamed Khaled",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Battery Capacity",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "75 kWh",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Horsepower",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "184 bhp",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Odometer",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "85,000 km",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Year",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "2020",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assigned Marketer",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "yasser mohamed",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Transmission",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "Automatic",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Engine Type",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "Petrol",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Color",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "Gray",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              "Category",
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              "Sedan",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),


      ],
    );
  }
}
