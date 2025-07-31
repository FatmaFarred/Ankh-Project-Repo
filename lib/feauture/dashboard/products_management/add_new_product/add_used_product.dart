import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager/font_manager.dart';
import '../../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../../domain/entities/product_post_entity.dart';
import '../../../inspector_screen/widgets/custom_text_form_field.dart';
import '../../dashboard_main screen _drawer/dashboard_main_screen _drawer.dart';
import 'cubit/post_product_cubit.dart';

class AddUsedProduct extends StatefulWidget {
  const AddUsedProduct({super.key});

  @override
  State<AddUsedProduct> createState() => _AddUsedProductState();
}

class _AddUsedProductState extends State<AddUsedProduct> {
  String? selectedTransmission = 'Automatic';

  String? selectedFuel = 'Petrol';

  String? selectedMarketer = 'Mohamed Khaled';

  String? selectedStatus = 'Available';

  String? selectedDriveType = 'FrontWheel';

  late int statusNum;

  final List<String> driveTypes = ['FrontWheel', 'RearWheel', "AllWheel"];

  final List<String> transmissionTypes = ['Automatic', 'Manual'];

  final List<String> fuelTypes = ["Petrol", "Electric", "Gas"];

  final List<String> marketers = [
    'Mohamed Khaled',
    'Ahmed Mohamed',
    'Fahmy',
    'Mohamed Ahmed',
  ];

  final List<String> status = ['Available', 'Sold', " Reserved"];

  int currentIndex = 0;

  final List<Widget> screens = [
    Center(child: Text("New Screen")),
    Center(child: Text("Used Screen")),
  ];

  int selectedTabIndex = 0;

  final TextEditingController carNameController = TextEditingController();

  final TextEditingController categoryController = TextEditingController();

  final TextEditingController yearController = TextEditingController();

  final TextEditingController odometerController = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  final TextEditingController ownerNameController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController commissionController = TextEditingController();

  final TextEditingController requiredPointsController =
      TextEditingController();

  final TextEditingController horsepowerController = TextEditingController();

  final TextEditingController batteryCapacityController =
      TextEditingController();

  final TextEditingController licenseExpiryDateController =
      TextEditingController();

  final TextEditingController safetyReportController = TextEditingController();
  final TextEditingController taxStatusController = TextEditingController();

  final TextEditingController interiorConditionController =
      TextEditingController();

  final TextEditingController exteriorConditionController =
      TextEditingController();

  final TextEditingController additionalSpecsController =
      TextEditingController();

  final TextEditingController additionalInfoController =
      TextEditingController();

  final TextEditingController paymentMethodController = TextEditingController();

  final TextEditingController inspectionResultController =
      TextEditingController();

  final TextEditingController accidentHistoryController =
      TextEditingController();

  final TextEditingController testDriveAvailableController =
      TextEditingController();

  final TextEditingController warrantyStatusController =
      TextEditingController();

  final TextEditingController tireStatusController = TextEditingController();

  final TextEditingController lightStatusController = TextEditingController();

  final TextEditingController licenseDurationController =
      TextEditingController();

  final TextEditingController trafficViolationsController =
      TextEditingController();

  final TextEditingController insuranceStatusController =
      TextEditingController();

  final TextEditingController numberOfKeysController = TextEditingController();

  final TextEditingController seatConditionController = TextEditingController();

  final TextEditingController brakesConditionController =
      TextEditingController();

  final TextEditingController gearConditionController = TextEditingController();

  final TextEditingController driveSystemConditionController =
      TextEditingController();

  final TextEditingController tagsController = TextEditingController();

  final TextEditingController safetyStatusController = TextEditingController();

  @override
  void dispose() {
    carNameController.dispose();
    categoryController.dispose();
    yearController.dispose();
    odometerController.dispose();
    colorController.dispose();
    ownerNameController.dispose();
    locationController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    commissionController.dispose();
    horsepowerController.dispose();
    batteryCapacityController.dispose();
    requiredPointsController.dispose();
    licenseExpiryDateController.dispose();
    safetyReportController.dispose();
    interiorConditionController.dispose();
    exteriorConditionController.dispose();
    additionalSpecsController.dispose();
    additionalInfoController.dispose();
    paymentMethodController.dispose();
    inspectionResultController.dispose();
    accidentHistoryController.dispose();
    testDriveAvailableController.dispose();
    warrantyStatusController.dispose();
    tireStatusController.dispose();
    lightStatusController.dispose();
    licenseDurationController.dispose();
    trafficViolationsController.dispose();
    insuranceStatusController.dispose();
    numberOfKeysController.dispose();
    seatConditionController.dispose();
    brakesConditionController.dispose();
    gearConditionController.dispose();
    driveSystemConditionController.dispose();
    tagsController.dispose();
    safetyStatusController.dispose();
    taxStatusController.dispose();
    super.dispose();
  }

  void handleSubmit() {
    // Example: Access data
    print("Car Name: ${carNameController.text}");
    print("Category: ${categoryController.text}");
    print("Year: ${yearController.text}");
    print("Price: ${priceController.text}");
    print("Transmission: $selectedTransmission");
    // Add validation/saving logic here
  }

  final ImagePicker _picker = ImagePicker();

  List<XFile> _selectedImages = [];
  XFile? _selectedlicenseImage;
  XFile? _selectedinsuranceFrontPath ;
  XFile? _selectedInsuranceBackPath;

  void pickSingleImage({required Function(XFile?) onImagePicked}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    onImagePicked(image);
  }

  Future<void> pickMultipleImages({
    required Function(List<XFile>) onImagesPicked,
  }) async {
    final ImagePicker picker = ImagePicker();

    try {
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        onImagesPicked(images);
      }
    } catch (e) {
      // You can log or rethrow
      print('Image picking error: $e');
    }
  }

  Future<void> _pickdate() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null) {
      licenseExpiryDateController.text =
      pickedDate.toLocal().toString().split(' ')[0]; // Format: yyyy-MM-dd
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                CustomTextFormField(
                  hintText: "Car Name",
                  controller: carNameController,
                ),
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
                          CustomTextFormField(
                            hintText: "Category",
                            controller: categoryController,
                          ),
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
                          CustomTextFormField(
                            keyBoardType: TextInputType.number,
                            hintText: "Year",
                            controller: yearController,
                          ),
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
                            "Mileage",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          CustomTextFormField(
                            keyBoardType: TextInputType.number,
                            hintText: "Mileage",
                            controller: odometerController,
                          ),
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
                          CustomTextFormField(
                            hintText: "Color",
                            controller: colorController,
                          ),
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
                            "Horse Power",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          CustomTextFormField(
                            keyBoardType: TextInputType.number,
                            hintText: "Horse Power",
                            controller: horsepowerController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Battery Capacity",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          CustomTextFormField(
                            keyBoardType: TextInputType.number,
                            hintText: "Battery Capacity",
                            controller: batteryCapacityController,
                          ),
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
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
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
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFuel = value!;
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

                Text(
                  'Drive Type',
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
                  value: selectedDriveType,
                  items: driveTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDriveType = value!;
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
                    Icon(Icons.person, color: Colors.blueAccent, size: 20.sp),
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
                CustomTextFormField(
                  hintText: "Owner Name",
                  controller: ownerNameController,
                ),
                const SizedBox(height: 16),

                Text(
                  "Location",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  hintText: "Location",
                  controller: locationController,
                ),
                const SizedBox(height: 16),

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
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "Price",
                  controller: priceController,
                ),
                const SizedBox(height: 16),

                Text(
                  "commission",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "commission",
                  controller: commissionController,
                ),
                const SizedBox(height: 16),

                Text(
                  "Required Points",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "Required Points",
                  controller: requiredPointsController,
                ),
                const SizedBox(height: 16),

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
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (selectedStatus == "Available") {
                      statusNum = 1;
                    } else if (selectedStatus == "Sold") {
                      statusNum = 2;
                    } else {
                      statusNum = 3;
                    }
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
                      Icons.attach_money_rounded,
                      color: ColorManager.lightprimary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Condition Parts",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  "licenseExpiryDate",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  hintText: "License Expiry Date",
                  controller: licenseExpiryDateController,
                  onTab: _pickdate,
                ),
                const SizedBox(height: 16),

                Text(
                  "safetyReport",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "safetyReport",
                  controller: safetyReportController,
                ),
                const SizedBox(height: 16),

                Text(
                  "taxStatus",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "taxStatus",
                  controller: taxStatusController,
                ),
                const SizedBox(height: 16),

                Text(
                  "interiorCondition",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "interiorCondition",
                  controller: interiorConditionController,
                ),
                const SizedBox(height: 16),

                Text(
                  "exteriorCondition",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "exteriorCondition",
                  controller: exteriorConditionController,
                ),
                const SizedBox(height: 16),

                Text(
                  "additionalSpecs",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "additionalSpecs",
                  controller: additionalSpecsController,
                ),
                const SizedBox(height: 16),

                Text(
                  "additionalInfo",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.text,
                  hintText: "additionalInfo",
                  controller: additionalInfoController,
                ),
                const SizedBox(height: 16),

                Text(
                  "payment Method",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.text,
                  hintText: "payment Method",
                  controller: paymentMethodController,
                ),
                const SizedBox(height: 16),

                Text(
                  "inspectionResult",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "inspectionResult",
                  controller: inspectionResultController,
                ),
                const SizedBox(height: 16),

                Text(
                  "accidentHistory",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "accidentHistory",
                  controller: accidentHistoryController,
                ),
                const SizedBox(height: 16),

                Text(
                  "testDriveAvailable",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "testDriveAvailable",
                  controller: testDriveAvailableController,
                ),
                const SizedBox(height: 16),

                Text(
                  "warrantyStatus",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "warrantyStatus",
                  controller: warrantyStatusController,
                ),
                const SizedBox(height: 16),

                Text(
                  "tireStatus",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "tireStatus",
                  controller: tireStatusController,
                ),
                const SizedBox(height: 16),

                Text(
                  "lightStatus",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "lightStatus",
                  controller: lightStatusController,
                ),
                const SizedBox(height: 16),

                Text(
                  "licenseDuration",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "licenseDuration",
                  controller: licenseDurationController,
                ),
                const SizedBox(height: 16),

                Text(
                  "trafficViolations",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "trafficViolations",
                  controller: trafficViolationsController,
                ),
                const SizedBox(height: 16),

                Text(
                  "insuranceStatus",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "insuranceStatus",
                  controller: insuranceStatusController,
                ),
                const SizedBox(height: 16),

                Text(
                  "numberOfKeys",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "numberOfKeys",
                  controller: numberOfKeysController,
                ),
                const SizedBox(height: 16),

                Text(
                  "seatCondition",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "seatCondition",
                  controller: seatConditionController,
                ),
                const SizedBox(height: 16),

                Text(
                  "gearCondition",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "gearCondition",
                  controller: gearConditionController,
                ),
                const SizedBox(height: 16),

                Text(
                  "driveSystemCondition",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "driveSystemCondition",
                  controller: driveSystemConditionController,
                ),
                const SizedBox(height: 16),

                Text(
                  "brakesCondition",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "brakesCondition",
                  controller: brakesConditionController,
                ),
                const SizedBox(height: 16),

                Text(
                  "tags",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "tags",
                  controller: tagsController,
                ),
                const SizedBox(height: 16),

                Text(
                  "safetyStatus",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  keyBoardType: TextInputType.numberWithOptions(),
                  hintText: "safetyStatus",
                  controller: safetyStatusController,
                ),
                const SizedBox(height: 16),
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
                    Icon(Icons.image, color: Colors.blueAccent, size: 20.sp),
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

                _selectedImages.isEmpty
                    ? SizedBox()
                    : SizedBox(
                        height: 120.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                width: 120.w,
                                height: 120.h,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        ),
                      ),

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
                              color: ColorManager.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 75.0,
                            ),
                            child: CustomizedElevatedButton(
                              bottonWidget: Text(
                                "Browse Files",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: ColorManager.white,
                                    ),
                              ),
                              onPressed: () {
                                pickMultipleImages(
                                  onImagesPicked: (pickedImages) {
                                    setState(() {
                                      _selectedImages = pickedImages;
                                    });
                                  },
                                );
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
                    Icon(Icons.image, color: Colors.blueAccent, size: 20.sp),
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

                _selectedInsuranceBackPath == null
                    ? SizedBox()
                    : SizedBox(
                  height: 120.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(_selectedInsuranceBackPath!.path),
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

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
                              color: ColorManager.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 75.0,
                            ),
                            child: CustomizedElevatedButton(
                              bottonWidget: Text(
                                "Browse Files",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: ColorManager.white,
                                ),
                              ),
                              onPressed: () {
                                pickSingleImage(
                                  onImagePicked: (pickedImage) {
                                    if (pickedImage != null) {
                                      setState(() {
                                        _selectedInsuranceBackPath = pickedImage;
                                      });
                                    }
                                  },
                                );
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
                    Icon(Icons.image, color: Colors.blueAccent, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      "License images",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _selectedlicenseImage == null
                    ? SizedBox()
                    : SizedBox(
                  height: 120.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(_selectedlicenseImage!.path),
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  )
                ),

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
                              color: ColorManager.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 75.0,
                            ),
                            child: CustomizedElevatedButton(
                              bottonWidget: Text(
                                "Browse Files",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: ColorManager.white,
                                ),
                              ),
                              onPressed: () {
                                pickSingleImage(
                                  onImagePicked: (pickedImage) {
                                    if (pickedImage != null) {
                                      setState(() {
                                        _selectedlicenseImage = pickedImage;
                                      });
                                    }
                                  },
                                );
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
                    Icon(Icons.image, color: Colors.blueAccent, size: 20.sp),
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

                _selectedinsuranceFrontPath==null
                    ? SizedBox()
                    : SizedBox(
                  height: 120.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(_selectedinsuranceFrontPath!.path),
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  )
                ),

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
                              color: ColorManager.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 75.0,
                            ),
                            child: CustomizedElevatedButton(
                              bottonWidget: Text(
                                "Browse Files",
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: ColorManager.white,
                                ),
                              ),
                              onPressed: () {
                                pickSingleImage(
                                  onImagePicked: (pickedImage) {
                                    if (pickedImage != null) {
                                      setState(() {
                                        _selectedinsuranceFrontPath = pickedImage;
                                      });
                                    }
                                  },
                                );
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
                    Icon(Icons.description, color: Colors.grey, size: 20.sp),
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
                CustomTextFormField(
                  hintText: "Clean car, no accidents, excellent condition",
                  maxLines: 4,
                  controller: descriptionController,
                ),
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
                  List<String> imagePaths = _selectedImages.map((file) => file.path).toList();

                  final productEntity = ProductPostEntity(
                    rating: "3",
                    topBrandId: 1.toString(),
                    requiredPoints: requiredPointsController.text,
                    commission: commissionController.text.trim(),
                    model: yearController.text.trim(),
                    make: selectedFuel!,
                    driveType: selectedDriveType!,
                    title: carNameController.text.trim(),
                    description: descriptionController.text.trim(),
                    price: priceController.text.trim(),
                    category: categoryController.text.trim(),
                    transmission: selectedTransmission!,
                    engineType: selectedFuel!,
                    year: yearController.text.trim(),
                    mileage: odometerController.text.trim(),
                    color: colorController.text.trim(),
                    status: statusNum.toString(),
                    images: imagePaths,
                    fuelType: selectedFuel!,
                    horsepower: horsepowerController.text.trim(),
                    batteryCapacity: batteryCapacityController.text.trim(),
                    isUsedVehicle: true,
                    usedDetails: {
                      "ownerName": ownerNameController.text.trim(),
                      "address": locationController.text.trim(),
                      "licenseExpiryDate": licenseExpiryDateController.text,
                      "safetyReport": safetyReportController.text.trim(),
                      "taxStatus": taxStatusController.text.trim(),
                      "interiorCondition": interiorConditionController.text.trim(),
                      "exteriorCondition": exteriorConditionController.text.trim(),
                      "additionalSpecs": additionalSpecsController.text.trim(),
                      "additionalInfo": additionalInfoController.text.trim(),
                      "paymentMethod": paymentMethodController.text.trim(),
                      "inspectionResult": inspectionResultController.text.trim(),
                      "accidentHistory": accidentHistoryController.text.trim(),
                      "testDriveAvailable": true,
                      "warrantyStatus": warrantyStatusController.text.trim(),
                      "tireStatus": tireStatusController.text.trim(),
                      "lightStatus": lightStatusController.text.trim(),
                      "licenseDuration": licenseDurationController.text.trim(),
                      "trafficViolations": trafficViolationsController.text.trim(),
                      "insuranceStatus": insuranceStatusController.text.trim(),
                      "numberOfKeys": numberOfKeysController.text.trim(),
                      "seatCondition": seatConditionController.text.trim(),
                      "brakesCondition": brakesConditionController.text.trim(),
                      "gearCondition": gearConditionController.text.trim(),
                      "driveSystemCondition": driveSystemConditionController.text.trim(),
                      "tags": tagsController.text.trim(),
                      "safetyStatus": safetyStatusController.text.trim(),
                      'licenseImage': _selectedlicenseImage?.path, // ✅ just pass the path string
                      'insuranceCardFront': _selectedinsuranceFrontPath?.path,
                      'insuranceCardBack': _selectedInsuranceBackPath?.path,
                    },

                  );

                  context.read<PostProductCubit>().postProduct(productEntity);

                },
                color: ColorManager.lightprimary,
                borderColor: ColorManager.lightprimary,
              ),
            ),
            SizedBox(width: 15.w),
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
            ),
          ],
        ),
      ],
    );
  }
}
