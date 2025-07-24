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
import '../users_management/users_management_screen.dart';
import 'marketer_details_screen.dart';

class MarketersManagementScreen extends StatelessWidget {
  MarketersManagementScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser Mohamed',
      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "joiningCode":"#45225587"
    },
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Suspended',
      'assignedmarketer': 'Yasser Mohamed',

      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "joiningCode":"#45225587"


    },
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser Mohamed',

      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "joiningCode":"#45225587"


    },
    {
      'name': 'Ali Ahmed',
      'phone': '+201012345678',
      'email': 'ahmed@example.com',
      'date': 'Dec 21, 2023',
      'status': 'Active',
      'assignedmarketer': 'Yasser Mohamed',

      'interestedCar': "2",
      "AssignedProductsNum":"5",
      "joiningCode":"#45225587"


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
                AppLocalizations.of(context)!.marketerManagement,
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
                return UserCard(user: user,showAssignedProductsNum: true,
                onViewPressed: () {
                 Navigator.of(context).pushNamed(
                     MarketerDetailsScreen.routeName,
                   arguments: user
                 );
                },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




