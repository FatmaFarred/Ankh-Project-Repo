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
import '../../../../domain/entities/top_brand_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home_screen/top_brands/cubit/top_brand_cubit.dart';
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
  
  String? selectedCarName;
  TopBrandEntity? selectedTopBrand;
  
  final List<String> carNames = [ 
    // Hyundai 
    'HB20','i10','i20','i30','Accent','Verna','Solaris','Aura','Grand i10 Sedan', 
    'Grand Metro','Elantra','Avante','i30 Sedan','Grandeur','Azera','HB20S', 
    'i30 Fastback','Ioniq 6','Sonata','i30 wagon','Alcazar','Grand Creta','Bayon', 
    'Casper','Casper Electric','Creta','Cantus', 
  
    // Kia 
    'Ceed','EV4','K3','K4','Picanto','Morning','Ray','K5','K8','K9','Pegas','Soluto', 
    'Ceed SW','Proceed','EV3','EV5','EV6','EV9','Niro','Seltos','Sonet','Sorento', 
    'Soul','Sportage', 
  
    // Chevrolet 
    'Blazer','Blazer EV','Captiva','Captiva PHEV','Captiva EV','Equinox','Equinox EV', 
    'Groove','Spark EUV','Tracker', 
  
    // BMW 
    '1 Series','2 Series Gran Coupé','3 Series','4 Series Gran Coupé','5 Series', 
    '7 Series','8 Series Gran Coupé','i3','i4','i5','i7','3 Series Wagon','5 Series Wagon', 
    'i5 Wagon','X1','X2','X3','X4','X5','X6','X7','XM','iX1','iX2','iX3','iX', 
    '2 Series Coupé','4 Series Coupé','4 Series Convertible','8 Series Coupé', 
    '8 Series Convertible','Z4','2 Series Active Tourer', 
  ];

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

  final TextEditingController marketerPointsController =
      TextEditingController();
  final TextEditingController inspectorPointsController =
      TextEditingController();

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
    marketerPointsController.dispose();
    inspectorPointsController.dispose();
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
  XFile? _selectedinsuranceFrontPath;

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
      licenseExpiryDateController.text = pickedDate.toLocal().toString().split(
        ' ',
      )[0]; // Format: yyyy-MM-dd
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch top brands when the widget initializes
    context.read<TopBrandCubit>().fetchTopBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                        AppLocalizations.of(context)!.basicInformation,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)!.carName,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: ColorManager.lightprimary),
                      ),
                      hintText: AppLocalizations.of(context)!.carName,
                    ),
                    value: selectedCarName,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.carNameRequired;
                      }
                      return null;
                    },
                    items: carNames.map((String car) {
                      return DropdownMenuItem<String>(
                        value: car,
                        child: Text(car),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCarName = newValue;
                        carNameController.text = newValue ?? '';
                      });
                    },
                  ),
                  
                  SizedBox(height: 16.h),
                  Text(
                    "Top Brand",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  BlocBuilder<TopBrandCubit, TopBrandState>(
                    builder: (context, state) {
                      if (state is TopBrandLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TopBrandLoaded) {
                        final brands = state.brands;
                        return DropdownButtonFormField<TopBrandEntity>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(color: ColorManager.lightprimary),
                            ),
                            hintText: AppLocalizations.of(context)!.selectTopBrand,
                          ),
                          value: selectedTopBrand,
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!.pleaseSelectTopBrand;
                            }
                            return null;
                          },
                          items: brands.map((TopBrandEntity brand) {
                            return DropdownMenuItem<TopBrandEntity>(
                              value: brand,
                              child: Text(brand.name),
                            );
                          }).toList(),
                          onChanged: (TopBrandEntity? newValue) {
                            setState(() {
                              selectedTopBrand = newValue;
                            });
                          },
                        );
                      } else if (state is TopBrandError) {
                        return Text("Error: ${state.message}", style: TextStyle(color: Colors.red));
                      }
                      return const Text("No brands available");
                    },
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.category,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                              hintText: AppLocalizations.of(context)!.category,
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
                              AppLocalizations.of(context)!.year,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                              keyBoardType: TextInputType.number,
                              hintText: AppLocalizations.of(context)!.year,
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
                              AppLocalizations.of(context)!.mileage,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                              keyBoardType: TextInputType.number,
                              hintText: AppLocalizations.of(context)!.mileage,
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
                              AppLocalizations.of(context)!.color,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                              hintText: AppLocalizations.of(context)!.color,
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
                              AppLocalizations.of(context)!.horsePower,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                              keyBoardType: TextInputType.number,
                              hintText: AppLocalizations.of(
                                context,
                              )!.horsePower,
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
                              AppLocalizations.of(context)!.batteryCapacity,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'required';
                                }
                                return null;
                              },
                              keyBoardType: TextInputType.number,
                              hintText: AppLocalizations.of(
                                context,
                              )!.batteryCapacity,
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
                        AppLocalizations.of(context)!.specifications,
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
                    AppLocalizations.of(context)!.transmissionType,
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
                    validator: (value) {
                      if (value == null ||
                          value == 'Choose Transmission Type') {
                        return 'Please select a valid transmission type';
                      }
                      return null;
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
                    AppLocalizations.of(context)!.fuelType,
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
                    validator: (value) {
                      if (value == null ||
                          value ==
                              AppLocalizations.of(context)!.chooseFuelType) {
                        return 'Please select a valid fuel type';
                      }
                      return null;
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
                    AppLocalizations.of(context)!.driveType,
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
                    validator: (value) {
                      if (value == null ||
                          value ==
                              AppLocalizations.of(context)!.chooseDriveType) {
                        return 'Please select a valid drive type';
                      }
                      return null;
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
                    AppLocalizations.of(
                      context,
                    )!.ownerName,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    hintText:  AppLocalizations.of(
                      context,
                    )!.ownerName,
                    controller: ownerNameController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.location,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    hintText:  AppLocalizations.of(
                      context,
                    )!.location,
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
                    AppLocalizations.of(context)!.price,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Price  is required';
                      }
                      return null;
                    },
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText: AppLocalizations.of(context)!.price,
                    controller: priceController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(context)!.commission,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Commission is required';
                      }
                      return null;
                    },
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText: AppLocalizations.of(context)!.commission,
                    controller: commissionController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(context)!.requiredPoints,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText: AppLocalizations.of(context)!.requiredPoints,
                    controller: requiredPointsController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(context)!.marketerPoints,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required Points is required';
                      }
                      return null;
                    },
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText: AppLocalizations.of(context)!.marketerPoints,
                    controller: marketerPointsController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(context)!.inspectorPoints,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required Points is required';
                      }
                      return null;
                    },
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText: AppLocalizations.of(context)!.inspectorPoints,
                    controller: inspectorPointsController,
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
                        AppLocalizations.of(context)!.conditionParts,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(context)!.licenseExpiryDate,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.licenseExpiryDate,
                    controller: licenseExpiryDateController,
                    onTab: _pickdate,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(context)!.safetyReport,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText: AppLocalizations.of(context)!.safetyReport,
                    controller: safetyReportController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(context)!.taxStatus,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                  hintText:   AppLocalizations.of(context)!.taxStatus,
                    controller: taxStatusController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.interiorCondition,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.interiorCondition,
                    controller: interiorConditionController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.exteriorCondition,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText: AppLocalizations.of(
                      context,
                    )!.exteriorCondition,
                    controller: exteriorConditionController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.additionalSpecs,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.additionalSpecs,
                    controller: additionalSpecsController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.additionalInfo,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.text,
                    hintText:  AppLocalizations.of(
                      context,
                    )!.additionalInfo,
                    controller: additionalInfoController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.paymentMethod,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.text,
                    hintText:  AppLocalizations.of(
                      context,
                    )!.paymentMethods,
                    controller: paymentMethodController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.inspectionResult,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.inspectionResult,
                    controller: inspectionResultController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.accidentHistory,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.accidentHistory,
                    controller: accidentHistoryController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.testDriveAvailable,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.testDriveAvailable,
                    controller: testDriveAvailableController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.warrantyStatus,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.warrantyStatus,
                    controller: warrantyStatusController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.tireStatus,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.tireStatus,
                    controller: tireStatusController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.lightStatus,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.lightStatus,
                    controller: lightStatusController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.licenseDuration,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.text,
                    hintText:  AppLocalizations.of(
                      context,
                    )!.licenseDuration,
                    controller: licenseDurationController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.trafficViolations,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.text,
                    hintText:  AppLocalizations.of(
                      context,
                    )!.trafficViolations,
                    controller: trafficViolationsController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.insuranceStatus,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.insuranceStatus,
                    controller: insuranceStatusController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.numberOfKeys,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.numberOfKeys,
                    controller: numberOfKeysController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.seatCondition,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.seatCondition,
                    controller: seatConditionController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.gearCondition,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.gearCondition,
                    controller: gearConditionController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.driveSystemCondition,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.driveSystemCondition,
                    controller: driveSystemConditionController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.brakesCondition,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.brakesCondition,
                    controller: brakesConditionController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.tags,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.tags,
                    controller: tagsController,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.safetyStatus,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    keyBoardType: TextInputType.numberWithOptions(),
                    hintText:  AppLocalizations.of(
                      context,
                    )!.safetyStatus,
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
                        AppLocalizations.of(
                          context,
                        )!.images,
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
                                  AppLocalizations.of(
                                    context,
                                  )!.browseFiles,
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
                        AppLocalizations.of(
                          context,
                        )!.insuranceFront,
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
                                  AppLocalizations.of(
                                    context,
                                  )!.browseFiles,
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
                                          _selectedInsuranceBackPath =
                                              pickedImage;
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
                        AppLocalizations.of(
                          context,
                        )!.insuranceBack,
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
                                  AppLocalizations.of(
                                    context,
                                  )!.browseFiles,
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
                        AppLocalizations.of(
                          context,
                        )!.licenseImage,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _selectedinsuranceFrontPath == null
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
                                  AppLocalizations.of(
                                    context,
                                  )!.browseFiles,
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
                                          _selectedinsuranceFrontPath =
                                              pickedImage;
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
                        AppLocalizations.of(
                          context,
                        )!.description,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.description,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
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
                    List<String> imagePaths = _selectedImages
                        .map((file) => file.path)
                        .toList();
                    if (_formKey.currentState!.validate()) {
                      final productEntity = ProductPostEntity(
                        rating: "3",
                        topBrandId: selectedTopBrand?.id.toString() ?? '1',
                        requiredPoints: requiredPointsController.text,
                        commission: commissionController.text.trim(),
                        marketerPoints: marketerPointsController.text.trim(),
                        inspectorPoints: inspectorPointsController.text.trim(),
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
                          "interiorCondition": interiorConditionController.text
                              .trim(),
                          "exteriorCondition": exteriorConditionController.text
                              .trim(),
                          "additionalSpecs": additionalSpecsController.text
                              .trim(),
                          "additionalInfo": additionalInfoController.text
                              .trim(),
                          "paymentMethod": paymentMethodController.text.trim(),
                          "inspectionResult": inspectionResultController.text
                              .trim(),
                          "accidentHistory": accidentHistoryController.text
                              .trim(),
                          "testDriveAvailable": true,
                          "warrantyStatus": warrantyStatusController.text
                              .trim(),
                          "tireStatus": tireStatusController.text.trim(),
                          "lightStatus": lightStatusController.text.trim(),
                          "licenseDuration": licenseDurationController.text
                              .trim(),
                          "trafficViolations": trafficViolationsController.text
                              .trim(),
                          "insuranceStatus": insuranceStatusController.text
                              .trim(),
                          "numberOfKeys": numberOfKeysController.text.trim(),
                          "seatCondition": seatConditionController.text.trim(),
                          "brakesCondition": brakesConditionController.text
                              .trim(),
                          "gearCondition": gearConditionController.text.trim(),
                          "driveSystemCondition": driveSystemConditionController
                              .text
                              .trim(),
                          "tags": tagsController.text.trim(),
                          "safetyStatus": safetyStatusController.text.trim(),
                          'licenseImage': _selectedlicenseImage?.path,
                          // ✅ just pass the path string
                          'insuranceCardFront':
                              _selectedinsuranceFrontPath?.path,
                          'insuranceCardBack': _selectedInsuranceBackPath?.path,
                        },
                      );

                      context.read<PostProductCubit>().postProduct(
                        productEntity,
                      );
                    }
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
      ),
    );
  }
}
