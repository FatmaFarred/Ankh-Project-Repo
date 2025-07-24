import 'package:ankh_project/core/constants/font_manager/font_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/color_manager.dart';
import '../../../l10n/app_localizations.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  String? selectedTransmission = 'Automatic';
  String? selectedFuel = 'Gasoline';
  String? selectedMarketer = 'Mohamed Khaled';
  String? selectedStatus = 'Available';

  final List<String> transmissionTypes = ['Automatic', 'Manual'];
  final List<String> fuelTypes = ['Gasoline', 'Diesel', 'Electric', 'Hybrid'];
  final List<String> marketers = [
    'Mohamed Khaled',
    'Ahmed Mohamed',
    'Fahmy',
    'Mohamed Ahmed',
  ];
  final List<String> status = ['Available', 'Unavailable'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Add New Car"),
        backgroundColor: ColorManager.lightprimary,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 0,
                color: ColorManager.white,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: ColorManager.lightGrey),
                ),
                child: Padding(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: ColorManager.lightprimary,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Basic Information",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Car Name",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      CustomTextFormField(hintText: "Car Name"),

                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Category",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                CustomTextFormField(hintText: "Category"),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Year",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                CustomTextFormField(hintText: "Year"),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Odometer",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                CustomTextFormField(hintText: "Odometer"),
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Color",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                CustomTextFormField(hintText: "Color"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                elevation: 0,
                color: ColorManager.white,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: ColorManager.lightGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: ColorManager.lightprimary,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Specifications",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Transmission Type Dropdown
                      Text(
                        'Transmission Type',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.black,
                        ),
                        iconSize: 20.sp,
                        value: selectedTransmission,
                        items: transmissionTypes
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedTransmission = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Fuel Type Dropdown
                      Text(
                        'Fuel Type',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        iconSize: 20.sp,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.black,
                        ),
                        value: selectedFuel,
                        items: fuelTypes
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedFuel = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                elevation: 0,
                color: ColorManager.white,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: ColorManager.lightGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Owner & Assignment",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "Owner Name",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      CustomTextFormField(hintText: "Owner Name"),
                      const SizedBox(height: 16),

                      Text(
                        "Location",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      CustomTextFormField(hintText: "Location"),
                      const SizedBox(height: 16),

                      // Fuel Type Dropdown
                      Text(
                        'Assigned Marketer',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        iconSize: 20.sp,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.black,
                        ),
                        value: selectedMarketer,
                        items: marketers
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMarketer = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                elevation: 0,
                color: ColorManager.white,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: ColorManager.lightGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: ColorManager.lightprimary,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Pricing & Status",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "Price",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      CustomTextFormField(hintText: "Price"),
                      const SizedBox(height: 16),

                      // Fuel Type Dropdown
                      Text(
                        'Status',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        iconSize: 20.sp,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.black,
                        ),
                        value: selectedStatus,
                        items: status
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                elevation: 0,
                color: ColorManager.white,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: ColorManager.lightGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.blueAccent,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "images",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 0,
                        color: ColorManager.white,
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          side: BorderSide(color: ColorManager.lightGrey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  color: ColorManager.grey,
                                  size: 30.sp,
                                ),
                                Text(
                                  "Drag & drop images or",
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: ColorManager.grey
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 75.0),
                                  child: CustomizedElevatedButton(
                                    bottonWidget: Text(
                                      "Browse Files",
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontSize: 16.sp,
                                        color: ColorManager.white,
                                      ),
                                    ),
                                    onPressed: () {

                                    },
                                    color: ColorManager.lightprimary,
                                    borderColor: ColorManager.lightprimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 16.h),
              Card(
                elevation: 0,
                color: ColorManager.white,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: ColorManager.lightGrey),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Description",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Description",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      CustomTextFormField(hintText: "Clean car, no accidents, excellent condition",maxLines: 4,),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomizedElevatedButton(
                    bottonWidget: Text(
                      "Add Product",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                      ),
                    ),
                    onPressed: () {

                    },
                    color: ColorManager.lightprimary,
                    borderColor: ColorManager.lightprimary,
                  ),
                ),
                SizedBox(width: 15.w,),
                Expanded(
                  child: CustomizedElevatedButton(
                    bottonWidget: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: ColorManager.grey,
                    borderColor: ColorManager.grey,
                  ),
                )
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}
