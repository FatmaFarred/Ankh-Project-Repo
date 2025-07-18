import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/home_screen/header_section.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InspectorHomeScreen extends StatelessWidget {
  const InspectorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            SizedBox(height: 12.h),
            Container(
              height: 650.h,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.h);
                  },
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Color(0xFFC5FEC3),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.active,
                                  style: GoogleFonts.inter(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF279C07),
                                  ),
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
                          CustomizedElevatedButton(
                            bottonWidget: Text(
                              "Accept Inspection",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: ColorManager.white,
                                    fontSize: 16.sp,
                                  ),
                            ),
                            color: Theme.of(context).primaryColor,
                            borderColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         const InspectionDetailsScreen(),
                              //   ),
                              // );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
