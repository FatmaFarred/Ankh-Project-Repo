import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:ankh_project/feauture/dashboard/users_management/user_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../l10n/app_localizations.dart';
import 'inspector_details_screen.dart';

class InspectorManagementScreen extends StatelessWidget {
  InspectorManagementScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Amr',
      'phone': '+201012345678',
      'email': 'Amr@example.com',
      'date': 'Jul 5, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser Mohamed',
      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "Completed":"12",
      "totalinspections":"2"
    },
    {
      'name': 'yasser',
      'phone': '+201012345678',
      'email': 'yasser@example.com',
      'date': 'Dec 30, 2023',
      'status': 'Suspended',
      'assignedmarketer': 'kaream Mohamed',

      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "Completed":"12",
      "totalinspections":"2"


    },
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': ' Mohamed',

      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "Completed":"12",
      "totalinspections":"2"


    },
    {
      'name': 'Ali ',
      'phone': '+201012345678',
      'email': 'Ali@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser ',

      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "Completed":"12",
      "totalinspections":"2"


    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.inspectorManagement,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize:18.sp ),
              ),
              // Profile image or icon can go here
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(

              hintText: AppLocalizations.of(context)!.search,

              prefixIcon: Icon(Icons.search, color: ColorManager.lightGreyShade2),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return InspectorCard(user: user,onViewPressed: () {
                  Navigator.of(context).pushNamed(
                    InspectorDetailsScreen.routeName,
                    arguments: user,
                  );
                },);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InspectorCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool showBottons;
  final VoidCallback? onViewPressed;

  const InspectorCard(
      {Key? key, required this.user, this.showBottons = true, this.onViewPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = user['status'] == 'Active';
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.userIcon, height: 18.h, width: 18.w,),
                SizedBox(width: 6.w),
                Text(
                  user['name'],
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFDCFCE7) : const Color(
                        0xFFFFEDD5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user['status'],
                    style: TextStyle(
                      color: isActive ? const Color(0xFF166534) : const Color(
                          0xFF9A3412),
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
                  ImageAssets.callIcon, height: 18.h, width: 18.w,),
                SizedBox(width: 6.w),
                Text(user['phone'],
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.mailIcon, height: 18.h, width: 18.w,),
                SizedBox(width: 6.w),
                Text(user['email'],
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.calenderIcon, height: 18.h, width: 18.w,),

                SizedBox(width: 6.w),
                Text(user['date'],
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.visibility, color: ColorManager.lightprimary,
                    size: 20.sp),

                SizedBox(width: 6.w),
                Text("${AppLocalizations.of(context)!.totalInspections} :",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
                Text(user['totalinspections'],
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.completedIcon, height: 18.h, width: 18.w,),

                SizedBox(width: 6.w),
                Text("${AppLocalizations.of(context)!.completed} :",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
                Text(user['Completed'],
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            showBottons ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorManager.white,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: ColorManager.darkGrey)),
                  ),
                  onPressed: onViewPressed,
                  icon: Icon(
                      Icons.visibility, color: Color(0xffD4AF37), size: 20.sp),

                  label: Text(AppLocalizations.of(context)!.view,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        fontSize: 12.sp, color: ColorManager.lightprimary),

                  ),
                ),
                ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.white,

                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: ColorManager.darkGrey)),
                  ),
                  onPressed: () {
                    _showBottomSheet(
                      context: context,
                      title: AppLocalizations.of(context)!.deleteUserAccount,
                      description: AppLocalizations.of(context)!
                          .deleteUserAccountSubtitle,
                      cancelText: AppLocalizations.of(context)!.cancel,
                      confirmText: AppLocalizations.of(context)!.delete,
                      onCancel: () => Navigator.pop(context),
                      onConfirm: () {},
                      icon: Icon(Icons.delete, color: ColorManager.error),

                    );
                  },
                  icon: Icon(
                      Icons.delete, color: ColorManager.error, size: 20.sp),

                  label: Text(AppLocalizations.of(context)!.delete,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        fontSize: 12.sp, color: ColorManager.lightprimary),

                  ),
                ),
                ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorManager.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: ColorManager.darkGrey)),
                  ),
                  onPressed: () {
                    _showBottomSheet(
                      context: context,
                      title: AppLocalizations.of(context)!.suspendUserAccount,
                      description: AppLocalizations.of(context)!
                          .suspendUserAccountSubtitle,
                      cancelText: AppLocalizations.of(context)!.cancel,
                      confirmText: AppLocalizations.of(context)!.confirm,
                      onCancel: () => Navigator.pop(context),
                      onConfirm: () {},
                      icon: Icon(Icons.lock, color: ColorManager.error),

                    );
                  },
                  icon: Icon(Icons.lock, color: ColorManager.lightprimary,
                      size: 20.sp),

                  label: Text(isActive
                      ? AppLocalizations.of(context)!.suspend
                      : AppLocalizations.of(context)!.unsuspend,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                        fontSize: 12.sp, color: ColorManager.lightprimary),

                  ),
                ),
              ],

            ) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

// ... inside your widget class

  void _showBottomSheet({ required BuildContext context,
    required String title,
    required String description,
    required String cancelText,
    required String confirmText,
    required VoidCallback onCancel,
    required VoidCallback onConfirm,
    Color? cancelColor,
    Color? confirmColor,
    Widget ? icon,


  }) {
  }
}