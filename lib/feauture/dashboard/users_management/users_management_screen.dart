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

class UsersManagementScreen extends StatelessWidget {
  UsersManagementScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser Mohamed',
      'interestedCar': "2",
      "AssignedProductsNum":"5"
    },
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Suspended',
      'assignedmarketer': 'Yasser Mohamed',

      'interestedCar': "2",
    "AssignedProductsNum":"5"

    },
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser Mohamed',

      'interestedCar': "2",
      "AssignedProductsNum":"5"

    },
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser Mohamed',

      'interestedCar': "2",
      "AssignedProductsNum":"5"

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
                AppLocalizations.of(context)!.usersManagement,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomizedElevatedButton(bottonWidget: Row(
              children: [
                Icon(Icons.add_circle_outline, color: ColorManager.white, size: 24.sp),
                SizedBox(width: 8.w,),
                Text(AppLocalizations.of(context)!.addNewUser,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
              ],
            )
              , onPressed: () {
                // Handle suspend account action

              },
              color:  ColorManager.lightprimary ,
              borderColor:  ColorManager.lightprimary ,


            ),
          )
          ,
          Expanded(
            child: ListView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(user: user,onViewPressed: () {
                  Navigator.of(context).pushNamed(
                    UserDetailsScreen.routeName,
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

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool showAssignedProductsNum;
  final VoidCallback onViewPressed;
  const UserCard({Key? key, required this.user, this.showAssignedProductsNum=false, required this.onViewPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = user['status'] == 'Active';
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin:  EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r),side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(ImageAssets.userIcon, height: 18.h,width: 18.w,),
                 SizedBox(width: 6.w),
                Text(
                  user['name'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                const Spacer(),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFDCFCE7) : const Color(0xFFFFEDD5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    user['status'],
                    style: TextStyle(
                      color: isActive ? const Color(0xFF166534) : const Color(0xFF9A3412),
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
                SvgPicture.asset(ImageAssets.callIcon, height: 18.h,width: 18.w,),
                 SizedBox(width: 6.w),
                Text(user['phone'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
             SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(ImageAssets.mailIcon, height: 18.h,width: 18.w,),
                 SizedBox(width: 6.w),
                Text(user['email'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
             SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(ImageAssets.calenderIcon, height: 18.h,width: 18.w,),

                SizedBox(width: 6.w),
                Text(user['date'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
           showAssignedProductsNum? Row(
              children: [
                SvgPicture.asset(ImageAssets.assignedIcon, height: 18.h,width: 18.w,),

                SizedBox(width: 6.w),
                Text("${AppLocalizations.of(context)!.assignedProducts} :",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),

                Text(user['AssignedProductsNum'],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ):SizedBox.shrink(),
             SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorManager.white,

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: ColorManager.darkGrey)),
                  ),
                  onPressed: onViewPressed,
                  icon: Icon(Icons.visibility, color: Color(0xffD4AF37), size: 20.sp),

                  label:Text(AppLocalizations.of(context)!.view,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: ColorManager.lightprimary),

                  ),
                ),
                ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.white,

                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: ColorManager.darkGrey)),
                  ),
                  onPressed: () {
                    _showBottomSheet(context: context, title: AppLocalizations.of(context)!.deleteUserAccount, description: AppLocalizations.of(context)!.deleteUserAccountSubtitle, cancelText: AppLocalizations.of(context)!.cancel, confirmText:AppLocalizations.of(context)!.delete , onCancel: ()=>Navigator.pop(context), onConfirm: (){},
                      icon: Icon(Icons.delete, color: ColorManager.error),

                    );
                  },
                  icon: Icon(Icons.delete, color: ColorManager.error, size: 20.sp),

                  label:Text(AppLocalizations.of(context)!.delete,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: ColorManager.lightprimary),

                  ),
                ),
                ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorManager.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: ColorManager.darkGrey)),
                  ),
                  onPressed: () {
                    _showBottomSheet(context: context, title: AppLocalizations.of(context)!.suspendUserAccount, description: AppLocalizations.of(context)!.suspendUserAccountSubtitle, cancelText: AppLocalizations.of(context)!.cancel, confirmText:AppLocalizations.of(context)!.confirm , onCancel: ()=>Navigator.pop(context), onConfirm: (){},
                      icon: Icon(Icons.lock, color: ColorManager.error),

                    );
                  },
                  icon: Icon(Icons.lock, color: ColorManager.lightprimary, size: 20.sp),

                  label:Text(isActive ? AppLocalizations.of(context)!.suspend: AppLocalizations.of(context)!.unsuspend,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: ColorManager.lightprimary),

                  ),
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }

// ... inside your widget class

  void _showBottomSheet({ required BuildContext context,
    required  String title,
    required String description,
    required String cancelText,
    required String confirmText,
    required VoidCallback onCancel,
    required VoidCallback onConfirm,
      Color? cancelColor,
      Color? confirmColor,
    Widget ? icon,


  }) {
    showModalBottomSheet(

      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CustomBottomSheet(

        title: title,
        description: description,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: () => onCancel,
        onConfirm:()=>onConfirm,
        confirmColor: Colors.red,
        icon: icon,
      ),
    );
  }
} 