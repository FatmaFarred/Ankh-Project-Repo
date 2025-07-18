import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/l10n/app_localizations.dart';

class ClientProductInfoCard extends StatelessWidget {
  const ClientProductInfoCard({super.key});

  Widget infoRow(IconData icon, String label, String value, Color bgColor, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(icon, color: iconColor, size: 20.sp),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF4f4f4f),
                )),
            Text(value,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1e1e1e),
                )),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff777777).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Client & Product Information",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 16.h),
          infoRow(Icons.directions_car_filled, AppLocalizations.of(context)!.productName, "Toyota Corolla 2023", const Color(0xffDBEAFE), Colors.blue),
          SizedBox(height: 16.h),
          infoRow(Icons.person, AppLocalizations.of(context)!.clientName, "Mohamed Khaled", const Color(0xffDBEAFE), Colors.blue),
          SizedBox(height: 16.h),
          infoRow(Icons.phone, AppLocalizations.of(context)!.phoneNumber, "01061056458", const Color(0xffDBEAFE), Colors.blue),
          SizedBox(height: 16.h),
          infoRow(Icons.pin_drop, AppLocalizations.of(context)!.address, "15 El-Tahrir St., Cairo", const Color(0xffFFEDD5), Colors.red),
          SizedBox(height: 16.h),
          infoRow(Icons.calendar_today_rounded, AppLocalizations.of(context)!.appointment, "July 7, 2025 – 3:00 PM", const Color(0xffDBEAFE), Colors.blue),
        ],
      ),
    );
  }
}
