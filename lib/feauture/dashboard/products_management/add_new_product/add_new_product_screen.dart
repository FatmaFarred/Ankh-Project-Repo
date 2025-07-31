import 'dart:io';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/constants/font_manager/font_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/domain/entities/product_post_entity.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api_service/di/di.dart';
import '../../../../domain/use_cases/post_product_usecase.dart';
import '../../dashboard_main screen _drawer/dashboard_main_screen _drawer.dart';
import '../cubit/product_management_cubit.dart';
import '../products_management_screen.dart';
import 'Custom_Tab_Bar.dart';
import 'add_used_product.dart';
import 'cubit/post_product_cubit.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  String? selectedTransmission = 'Choose Transmission Type';
  String? selectedFuel = 'Choose Fuel Type';
  String? selectedMarketer = 'Mohamed Khaled';
  String? selectedStatus =  'Choose Status';
  String? selectedDriveType = 'Choose Drive Type';

  late int statusNum;

  final List<String> driveTypes = ['Choose Drive Type','FrontWheel', 'RearWheel', "AllWheel"];
  final List<String> transmissionTypes = ['Choose Transmission Type','Automatic', 'Manual'];
  final List<String> fuelTypes = ['Choose Fuel Type',"Petrol", "Electric", "Gas"];
  final List<String> marketers = [
    'Mohamed Khaled',
    'Ahmed Mohamed',
    'Fahmy',
    'Mohamed Ahmed',
  ];
  final List<String> status =  ['Choose Status', 'Available', 'Sold', 'Pending'];

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

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages = images;
        });
      }
    } catch (e) {
      // handle error here
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostProductCubit(getIt<PostProductUseCase>()),
      child: BlocListener<PostProductCubit, PostProductState>(
        listener: (context, state) {
          if (state is PostProductSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DashboardMainScreen()),
            );
          } else if (state is PostProductError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text("Add Car"),
            backgroundColor: ColorManager.lightprimary,
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomTabBar(
                      tabs: const ['New', 'Used'],
                      onTabChanged: (index) {
                        setState(() {
                          selectedTabIndex = index;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: selectedTabIndex == 0
                        ? Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  color: ColorManager.white,
                                  margin: EdgeInsets.symmetric(vertical: 8.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    side: BorderSide(
                                      color: ColorManager.lightGrey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: REdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                fontWeight:
                                                    FontWeightManager.semiBold,
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Car Name is required';
                                            }
                                            return null;
                                          },
                                          hintText: "Car Name",
                                          controller: carNameController,
                                        ),
                                        SizedBox(height: 16.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Category",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  CustomTextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim().isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    hintText: "Category",
                                                    controller:
                                                        categoryController,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Year",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  CustomTextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim().isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Mileage",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  CustomTextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim().isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
                                                    hintText: "Mileage",
                                                    controller:
                                                        odometerController,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Color",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  CustomTextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim().isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Horse Power",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  CustomTextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim().isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
                                                    hintText: "Horse Power",
                                                    controller:
                                                        horsepowerController,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Battery Capacity",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  CustomTextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim().isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
                                                    hintText:
                                                        "Battery Capacity",
                                                    controller:
                                                        batteryCapacityController,
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
                                    side: BorderSide(
                                      color: ColorManager.lightGrey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                fontWeight:
                                                    FontWeightManager.semiBold,
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
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight:
                                                FontWeightManager.semiBold,
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
                                          validator: (value) {
                                            if (value == null || value == 'Choose Transmission Type') {
                                              return 'Please select a valid transmission type';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        // Fuel Type Dropdown
                                        Text(
                                          'Fuel Type',
                                          style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          iconSize: 20.sp,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight:
                                                FontWeightManager.semiBold,
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
                                              selectedFuel = value!;
                                            });
                                          },
                                          validator: (value) {
                                            if (value == null || value == 'Choose Fuel Type') {
                                              return 'Please select a valid fuel type';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Drive Type',
                                          style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          iconSize: 20.sp,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                            color: ColorManager.black,
                                          ),
                                          value: selectedDriveType,
                                          items: driveTypes
                                              .map(
                                                (type) => DropdownMenuItem(
                                                  value: type,
                                                  child: Text(type),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedDriveType = value!;
                                            });
                                          },
                                          validator: (value) {
                                            if (value == null || value == 'Choose Drive Type') {
                                              return 'Please select a valid drive type';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                                    side: BorderSide(
                                      color: ColorManager.lightGrey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                fontWeight:
                                                    FontWeightManager.semiBold,
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Price  is required';
                                            }
                                            return null;
                                          },
                                          keyBoardType:
                                              TextInputType.numberWithOptions(),
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Commission is required';
                                            }
                                            return null;
                                          },
                                          keyBoardType:
                                              TextInputType.numberWithOptions(),
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Required Points is required';
                                            }
                                            return null;
                                          },
                                          keyBoardType:
                                              TextInputType.numberWithOptions(),
                                          hintText: "Required Points",
                                          controller: requiredPointsController,
                                        ),
                                        const SizedBox(height: 16),

                                        // Fuel Type Dropdown
                                        Text(
                                          'Status',
                                          style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          iconSize: 20.sp,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight:
                                                FontWeightManager.semiBold,
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
                                              if (value == "Available") {
                                                statusNum = 1;
                                              } else if (value == "Sold") {
                                                statusNum = 2;
                                              } else {
                                                statusNum = 3;
                                              }
                                            });
                                          },
                                          validator: (value) {
                                            if (value == null || value == 'Choose Status') {
                                              return 'Please select a valid status';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
                                    side: BorderSide(
                                      color: ColorManager.lightGrey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                fontWeight:
                                                    FontWeightManager.semiBold,
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
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      _selectedImages.length,
                                                  itemBuilder: (context, index) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8.r,
                                                          ),
                                                      child: Image.file(
                                                        File(
                                                          _selectedImages[index]
                                                              .path,
                                                        ),
                                                        width: 120.w,
                                                        height: 120.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(width: 10.w),
                                                ),
                                              ),

                                        Card(
                                          elevation: 0,
                                          color: ColorManager.white,
                                          margin: EdgeInsets.symmetric(
                                            vertical: 8.h,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            side: BorderSide(
                                              color: ColorManager.lightGrey,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                                                      fontWeight:
                                                          FontWeightManager
                                                              .semiBold,
                                                      color: ColorManager.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 75.0,
                                                        ),
                                                    child: CustomizedElevatedButton(
                                                      bottonWidget: Text(
                                                        "Browse Files",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                              fontSize: 16.sp,
                                                              color:
                                                                  ColorManager
                                                                      .white,
                                                            ),
                                                      ),
                                                      onPressed: _pickImages,
                                                      color: ColorManager
                                                          .lightprimary,
                                                      borderColor: ColorManager
                                                          .lightprimary,
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
                                    side: BorderSide(
                                      color: ColorManager.lightGrey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                fontWeight:
                                                    FontWeightManager.semiBold,
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Description is required';
                                            }
                                            return null;
                                          },
                                          hintText:
                                              "Clean car, no accidents, excellent condition",
                                          maxLines: 4,
                                          controller: descriptionController,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: CustomizedElevatedButton(
                                        bottonWidget: Text(
                                          "Add Product",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontSize: 16.sp,
                                                color: ColorManager.white,
                                              ),
                                        ),
                                        onPressed: () {
                                          List<String> imagePaths =
                                              _selectedImages
                                                  .map((file) => file.path)
                                                  .toList();

                                          if (_formKey.currentState!
                                              .validate()) {
                                            final productEntity =
                                                ProductPostEntity(
                                                  rating: "3",
                                                  topBrandId: 1.toString(),
                                                  requiredPoints:
                                                      requiredPointsController
                                                          .text
                                                          .trim(),
                                                  commission:
                                                      commissionController.text
                                                          .trim(),
                                                  model: yearController.text
                                                      .trim(),
                                                  make: selectedFuel!,
                                                  driveType: selectedDriveType!,
                                                  title: carNameController.text
                                                      .trim(),
                                                  description:
                                                      descriptionController.text
                                                          .trim(),
                                                  price: priceController.text
                                                      .trim(),
                                                  category: categoryController
                                                      .text
                                                      .trim(),
                                                  transmission:
                                                      selectedTransmission!,
                                                  engineType: selectedFuel!,
                                                  year: yearController.text
                                                      .trim(),
                                                  mileage: odometerController
                                                      .text
                                                      .trim(),
                                                  color: colorController.text
                                                      .trim(),
                                                  status: statusNum.toString(),
                                                  images: imagePaths,
                                                  fuelType: selectedFuel!,
                                                  horsepower:
                                                      horsepowerController.text
                                                          .trim(),
                                                  batteryCapacity:
                                                      batteryCapacityController
                                                          .text
                                                          .trim(),
                                                  isUsedVehicle: false,
                                                  usedDetails: null,
                                                );

                                            context
                                                .read<PostProductCubit>()
                                                .postProduct(productEntity);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DashboardMainScreen();
                                                },
                                              ),

                                            );
                                          }
                                          CustomDialog.positiveButton(
                                            context: context,
                                            title: "Added", // you may define this key in your l10n
                                            message: "the products have  been Added successfully.",
                                            positiveText: "OK",
                                            positiveOnClick: () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                          // All fields are valid, proceed to create ProductPostEntity
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
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
                            ),
                          )
                        : AddUsedProduct(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
