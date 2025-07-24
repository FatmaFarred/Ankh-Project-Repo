import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/home_screen/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../l10n/app_localizations.dart';
import '../../inspector_screen/widgets/photo_list_view.dart';
import '../custom_widgets/photo_list.dart';

class UserDetailsScreen extends StatelessWidget {
  static const String routeName = 'UserDetailsScreen';

  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final isActive = user['status'] == 'Active';
    final List<Map<String, String>> assignedProducts = [
      {
        'image': ImageAssets.carPic1, // Use your actual image asset
        'name': 'Toyota EX30',
        'price': 'EGP 1.9M – 2.3M',
      },
      {
        'image': ImageAssets.carPic2, // Use your actual image asset
        'name': 'BMW X5',
        'price': 'EGP 2.5M – 3.0M',
      },
      {
        'image': ImageAssets.carPic3, // Use your actual image asset
        'name': 'Mercedes-Benz GLE',
        'price': 'EGP 3.0M – 3.5M',
      },
      {
        'image': ImageAssets.carPic3, // Use your actual image asset
        'name': 'Audi Q7',
        'price': 'EGP 2.8M – 3.2M',
      },
      // Add more products as needed
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: ColorManager.lightprimary,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon:Icon (Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
            UserDetailsCard(user:user ),
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
                    "${AppLocalizations.of(context)!.interestedCars} ",
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
                itemCount: assignedProducts.length,
                itemBuilder: (context, index) {
                  final product = assignedProducts[index];
                  return AssignedProductCard(
                    image: product['image']!,
                    name: product['name']!,
                    price: product['price']!,
                    onDelete: () {  },
                  );
                },
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.imageIcon,
                    height: 18.h,
                    width: 18.w,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${AppLocalizations.of(context)!.images} ",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                  ),
          
                  SizedBox(width: 6.w),
          
                ],
              ),
              SizedBox(height: 12.h),
              PhotoList(imageUrls: [],),
              SizedBox(height: 20.h),
              CustomizedElevatedButton(bottonWidget: Text(AppLocalizations.of(context)!.suspendAccount,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16.sp,
                  color: ColorManager.white,
                ),
              )
                , onPressed: () {
                  // Handle suspend account action

                },
                color:  ColorManager.darkGrey ,
                borderColor:  ColorManager.darkGrey ,


              ),
              SizedBox(height: 16.h),
              CustomizedElevatedButton(bottonWidget: Text(AppLocalizations.of(context)!.addNewUser,
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

class AssignedProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final VoidCallback onDelete;

  const AssignedProductCard({
    required this.image,
    required this.name,
    required this.price,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              child: ClipRRect(

                borderRadius: BorderRadius.circular(8),
                child: Image.asset(image, width: 60, height: 60, fit: BoxFit.contain),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(ImageAssets.tagPriceIcon, height: 18.h, width: 18.w, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(price,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: ColorManager.lightprimary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFCD5D5),
                foregroundColor: ColorManager.error,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                padding: EdgeInsets.symmetric( vertical: 3),
              ),

              child: Text(AppLocalizations.of(context)!.delete, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14.sp,color: ColorManager.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
