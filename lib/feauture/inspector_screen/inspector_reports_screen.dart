import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/inspector_screen/inspection_report.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InspectorReportsScreen extends StatelessWidget {
  const InspectorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Reports Screen"),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SizedBox(
            height: 740.h,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF777777).withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "John Doe",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "July 8, 2025 ",
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF279C07),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Toyota Corolla 2023",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF4f4f4f),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: ColorManager.lightprimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "July 7, 2025 – 3:00 PM",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF4f4f4f),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14,
                            color: ColorManager.lightprimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            "15 El-Tahrir St., Cairo",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF4f4f4f),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 26.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Color(0xFFE5E7EB),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.completed,
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF279C07),
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),
                      CustomizedElevatedButton(
                        bottonWidget: Text(
                          "View Report",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: ColorManager.white,
                                fontSize: 16.sp,
                              ),
                        ),
                        color: Color(0xff777777),
                        borderColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return InspectionReport();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },
              itemCount: 12,
            ),
          ),
        ),
      ),
    );
  }
}
