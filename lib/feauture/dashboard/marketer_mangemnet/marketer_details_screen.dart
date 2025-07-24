import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../l10n/app_localizations.dart';
import '../users_management/user_details_screen.dart';

class MarketerDetailsScreen extends StatefulWidget {
  static const String routeName = 'MarketerDetailsScreen';



  const MarketerDetailsScreen({
    Key? key,

  }) ;

  @override
  State<MarketerDetailsScreen> createState() => _MarketerDetailsScreenState();
}

class _MarketerDetailsScreenState extends State<MarketerDetailsScreen> {
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
        title: Text(AppLocalizations.of(context)!.marketerDetails),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Marketer Info Card
              Card(
                elevation: 0,
                color:ColorManager.white ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: ColorManager.lightGrey)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.userIcon, height: 20.h,width: 20.w,color: Color(0xff9333EA),),
                          SizedBox(width: 8.w),
                          Text(AppLocalizations.of(context)!.marketerInfo, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _readonlyField(AppLocalizations.of(context)!.marketerName, user['name'] ?? ''),
                      _readonlyField(AppLocalizations.of(context)!.email, user['email'] ?? ''),
                      _readonlyField(AppLocalizations.of(context)!.phoneNumber, user['phone'] ?? ''),
                      _readonlyField(AppLocalizations.of(context)!.joiningCode, user['joiningCode'] ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Assigned Products Title
              Row(
                children: [
                  SvgPicture.asset(ImageAssets.assignedIcon, height: 20.h,width: 20.w,),
                  SizedBox(width: 6),
                  Text(AppLocalizations.of(context)!.assignedProducts,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final product = assignedProducts[index];
                  return AssignedProductCard(
                    image: product['image']!,
                    name: product['name']!,
                    price: product['price']!,
                    onButtonClick: () {},
                    TextButton: AppLocalizations.of(context)!.unassign,
                    TextColor:  ColorManager.darkGrey,


                  backgroundColor:Color(0xffD1D1D1),
                  );

                },
              ),
              SizedBox(height: 24),
              _actionButton(AppLocalizations.of(context)!.suspendAccount, ColorManager.darkGrey, Colors.white, () {}),
              SizedBox(height: 12),
              _actionButton(AppLocalizations.of(context)!.deleteMarketer, ColorManager.error, Colors.white, () {}),
              SizedBox(height: 12),
              _actionButton(AppLocalizations.of(context)!.assignNewProduct, ColorManager.lightprimary, Colors.white, () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _readonlyField(String label, String value,) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
          ),
          SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
            readOnly: true,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: ColorManager.lightGrey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String text, Color color, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: CustomizedElevatedButton(
        color:color ,
        borderColor: color,
        onPressed: onPressed,
        bottonWidget: Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp, color: textColor)),
      ),
    );
  }
}
