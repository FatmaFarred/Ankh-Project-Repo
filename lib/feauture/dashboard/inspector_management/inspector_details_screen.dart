import 'dart:ui';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/dashboard/inspector_management/inspector_management_screen.dart';
import 'package:ankh_project/feauture/home_screen/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/font_manager/font_style_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_containers/rounded_conatiner_image.dart';
import '../../../l10n/app_localizations.dart';
import '../../inspector_screen/widgets/photo_list_view.dart';
import '../../marketer_Reports/marketer_report_details/report_details.dart';
import '../../marketer_Reports/marketer_reports_screen.dart';
import '../../myrequest/status_handler_widgets.dart';
import '../custom_widgets/photo_list.dart';

class InspectorDetailsScreen extends StatelessWidget {
  static const String routeName = 'InspectorDetailsScreen';

  const InspectorDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final isActive = user['status'] == 'Active';
    final List<Map<String, dynamic>> inspection = [
      {
        'image': ImageAssets.carPic1, // Use your actual image asset
        'name': 'Toyota EX30',
        'price': 'EGP 1.9M – 2.3M',
        "resultSubmitted":"No",
        "status":"Completed",
        "inpsectorName":"Ali Ahmed",
        'date': 'Jul 5, 2023',

      },
      {
        'image': ImageAssets.carPic2, // Use your actual image asset
        'name': 'BMW X5',
        'price': 'EGP 2.5M – 3.0M',
        "resultSubmitted":"No",
        "status":"Completed",
        "inpsectorName":"Ali ",
        'date': 'Jul 5, 2023',



      },
      {
        'image': ImageAssets.carPic3, // Use your actual image asset
        'name': 'Mercedes-Benz GLE',
        'price': 'EGP 3.0M – 3.5M',
        "resultSubmitted":"yes",
        "status":"Pending",
        "inpsectorName":" Ahmed",
        'date': 'Jul 5, 2023',



      },
      {
        'image': ImageAssets.carPic3, // Use your actual image asset
        'name': 'Audi Q7',
        'price': 'EGP 2.8M – 3.2M',
        "resultSubmitted":"yes",
        "status":"Completed",
        "inpsectorName":"Amr yaseer",
        'date': 'Jul 5, 2023',




      },
      // Add more products as needed
    ];

    return Scaffold(
        appBar: AppBar(
          title:  Text(AppLocalizations.of(context)!.inspectionDetails),
          backgroundColor: ColorManager.lightprimary,
          leading: IconButton(onPressed: ()=>Navigator.pop(context), icon:Icon (Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: SingleChildScrollView(
            child: Column(
                children: [
                  InspectorCard(user:user,showBottons: false, ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.carIcon2,
                        height: 18.h,
                        width: 18.w,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "${AppLocalizations.of(context)!.inspectionHistory} ",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                      ),

                      SizedBox(width: 6.w),

                    ],
                  ),
                  SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: inspection.length,
                    itemBuilder: (context, index) {
                      final product = inspection[index];
                      return InspectionHistoryCard(
                       inspection: product,
                      );


                    },
                  ),
                  SizedBox(height: 24.h),
                  CustomizedElevatedButton(bottonWidget: Text(AppLocalizations.of(context)!.suspendAccount,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      color: ColorManager.white,
                    ),
                  )
                    , onPressed: () {
                      // Handle suspend account action

                    },
                    color:  ColorManager.lightprimary ,
                    borderColor:  ColorManager.lightprimary ,


                  ),
                  SizedBox(height: 16.h),
                  CustomizedElevatedButton(bottonWidget: Text(AppLocalizations.of(context)!.deleteInspector,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                      color: ColorManager.white,
                    ),
                  )
                    , onPressed: () {
                      // Handle suspend account action

                    },
                    color:  ColorManager.error ,
                    borderColor:  ColorManager.error ,


                  )









                ] ),
          ),
        ));
  }
}

class UserDetailsCard extends StatelessWidget {
  final Map<String, dynamic> user;


  const UserDetailsCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = user['status'] == 'Active';
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: ColorManager.lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.userIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  user['name'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFDCFCE7)
                        : const Color(0xFFFFEDD5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user['status'],
                    style: TextStyle(
                      color: isActive
                          ? const Color(0xFF166534)
                          : const Color(0xFF9A3412),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.callIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  user['phone'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.mailIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  user['email'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.carIcon2,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  "${AppLocalizations.of(context)!.interestedCars} :",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),

                SizedBox(width: 6.w),
                Text(
                  user['interestedCar'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.calenderIcon,
                  height: 18.h,
                  width: 18.w,
                ),

                SizedBox(width: 6.w),
                Text(
                  user['date'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),

            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.assignedIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  "${AppLocalizations.of(context)!.assignedMarketer} :",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(width: 6.w),
                Text(
                  user['assignedmarketer'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class InspectionHistoryCard extends StatelessWidget {
  final Map<String, dynamic> inspection;


  final VoidCallback? onViewReport;

  const InspectionHistoryCard({
    required this.inspection,
     this.onViewReport,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Image, Car Name, Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(inspection['image'], width: 64.w, height: 64.h, fit: BoxFit.contain),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(inspection['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.userIcon, width: 18.w, height: 18.h),
                          SizedBox(width: 4),
                          Text(inspection['inpsectorName'], style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),


                          ),
                        ],
                      ),

                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.calenderIcon, width: 18.w, height: 18.h),
                          SizedBox(width: 4),
                          Text(inspection['inpsectorName'], style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text('${AppLocalizations.of(context)!.resultSubmitted} : ${inspection['resultSubmitted']}', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFD5FCDB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    inspection['status'],
                    style: Theme.of(context,).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: Color(0xff166534)),
                  ),
                  ),


              ],
            ),
            SizedBox(height: 12),
            CustomizedElevatedButton(

    bottonWidget:Text(AppLocalizations.of(context)!.viewReport,
    style:Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp,color: ColorManager.white),
                        ),
              color: ColorManager.darkGrey,
              borderColor:ColorManager.darkGrey ,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  MarketerReportDetails.reportDetailsRouteName,
                  arguments: 36,
                );
              },



            ),
          ],
        ),
      ),
    );
  }
}