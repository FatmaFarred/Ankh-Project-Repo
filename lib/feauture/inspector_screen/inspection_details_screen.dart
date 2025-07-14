import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InspectionDetailsScreen extends StatelessWidget {
  const InspectionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.inspectionDetails),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  REdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff777777).withOpacity(0.5)
                  ),
                  borderRadius: BorderRadius.circular(16.r)
                ),
                padding: REdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Client & Product Information",style: Theme.of(context).textTheme.bodyLarge,),
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Color(0xffDBEAFE)
                          ),
                          child:Icon(Icons.directions_car_filled,color: Colors.blue,size: 20.sp,),
                        ),
                        SizedBox(width: 8.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.productName,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF4f4f4f),
                              ),),
                            Text(
                              "Toyota Corolla 2023",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1e1e1e),
                              ),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Color(0xffDBEAFE)
                          ),
                          child:Icon(Icons.person,color: ColorManager.lightprimary,size: 20.sp,),
                        ),
                        SizedBox(width: 8.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.clientName,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF4f4f4f),
                              ),),
                            Text(
                              "Mohamed Khaled",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1e1e1e),
                              ),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Color(0xffDBEAFE)
                          ),
                          child:Icon(Icons.phone,color: Colors.blue,size: 20.sp,),
                        ),
                        SizedBox(width: 8.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.phoneNumber,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF4f4f4f),
                              ),),
                            Text(
                              "01061056458",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1e1e1e),
                              ),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Color(0xffFFEDD5)
                          ),
                          child:Icon(Icons.pin_drop,color: Colors.red,size: 20.sp,),
                        ),
                        SizedBox(width: 8.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.address,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF4f4f4f),
                              ),),
                            Text(
                              "15 El-Tahrir St., Cairo",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1e1e1e),
                              ),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Color(0xffDBEAFE)
                          ),
                          child:Icon(Icons.calendar_today_rounded,color: Colors.blue,size: 20.sp,),
                        ),
                        SizedBox(width: 8.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.appointment,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Color(0xFF4f4f4f),
                              ),),
                            Text(
                              "July 7, 2025 – 3:00 PM",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1e1e1e),
                              ),),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
