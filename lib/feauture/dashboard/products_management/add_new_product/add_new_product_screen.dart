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
import '../../../../l10n/app_localizations.dart';
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
  String? selectedStatus = 'Choose Status';
  String? selectedDriveType = 'Choose Drive Type';
  String? selectedCarName;
  
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

  final List<String> driveTypes = [
    'Choose Drive Type',
    'FrontWheel',
    'RearWheel',
    "AllWheel",
  ];
  final List<String> transmissionTypes = [
    'Choose Transmission Type',
    'Automatic',
    'Manual',
  ];
  final List<String> fuelTypes = [
    'Choose Fuel Type',
    "Petrol",
    "Electric",
    "Gas",
  ];
  final List<String> marketers = [
    'Mohamed Khaled',
    'Ahmed Mohamed',
    'Fahmy',
    'Mohamed Ahmed',
  ];
  final List<String> status = ['Choose Status', 'Available', 'Sold', 'Reserved'];

  int currentIndex = 0;

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
  final TextEditingController marketerPointsController = TextEditingController();
  final TextEditingController inspectorPointsController = TextEditingController();
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
            title: Text(AppLocalizations.of(context)!.addCar),
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
                      tabs: [
                        AppLocalizations.of(context)!.neww,
                        AppLocalizations.of(context)!.used,
                      ],
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
                                              AppLocalizations.of(
                                                context,
                                              )!.basicInformation,
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
                                          AppLocalizations.of(context)!.carName,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        DropdownButtonFormField<String>(
                                          value: selectedCarName,
                                          decoration: InputDecoration(
                                            hintText: AppLocalizations.of(context)!.carName,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: ColorManager.lightGrey),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: ColorManager.lightGrey),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: ColorManager.lightprimary),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(color: Colors.red),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return AppLocalizations.of(context)!.carNameRequired;
                                            }
                                            return null;
                                          },
                                          items: carNames.map((String carName) {
                                            return DropdownMenuItem<String>(
                                              value: carName,
                                              child: Text(carName),
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
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.category,
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
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    hintText: AppLocalizations.of(
                                                      context,
                                                    )!.category,
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
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.year,
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
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
                                                    hintText:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.year,
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
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.mileage,
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
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
                                                    hintText:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.mileage,
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
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.color,
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
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    hintText:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.color,
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
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.horsePower,
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
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
                                                    hintText:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.horsePower,
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
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.batteryCapacity,
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
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'required';
                                                      }
                                                      return null;
                                                    },
                                                    keyBoardType:
                                                        TextInputType.number,
                                                    hintText:
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.batteryCapacity,
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
                                              AppLocalizations.of(
                                                context,
                                              )!.specifications,
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
                                          AppLocalizations.of(
                                            context,
                                          )!.transmissionType,
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
                                          value:selectedTransmission ,
                                          // AppLocalizations.of(
                                          //   context,
                                          // )!.chooseTransmissionType,
                                          items: transmissionTypes
                                              // [
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.chooseTransmissionType,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.automatic,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.manual,
                                              //     ]
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
                                            if (value == null ||
                                                value ==
                                                    'Choose Transmission Type') {
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
                                          AppLocalizations.of(
                                            context,
                                          )!.fuelType,
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
                                          // AppLocalizations.of(
                                          //   context,
                                          // )!.chooseFuelType,
                                          items: fuelTypes
                                              // [AppLocalizations.of(
                                              //         context,
                                              //       )!.chooseFuelType,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.petrol,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.electric,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.gas,
                                              //     ]
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
                                            if (value == null ||
                                                value ==
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.chooseFuelType) {
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
                                          AppLocalizations.of(
                                            context,
                                          )!.driveType,
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
                                          // AppLocalizations.of(
                                          //   context,
                                          // )!.chooseDriveType,
                                          items: driveTypes
                                              // [
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.chooseDriveType,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.frontWheel,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.rearWheel,
                                              //       AppLocalizations.of(
                                              //         context,
                                              //       )!.allWheel,
                                              //     ]
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
                                            if (value == null ||
                                                value ==
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.chooseDriveType) {
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
                                          AppLocalizations.of(context)!.price,
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
                                          hintText: AppLocalizations.of(
                                            context,
                                          )!.price,
                                          controller: priceController,
                                        ),
                                        const SizedBox(height: 16),

                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.commission,
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
                                          hintText: AppLocalizations.of(
                                            context,
                                          )!.commission,
                                          controller: commissionController,
                                        ),
                                        const SizedBox(height: 16),

                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.requiredPoints,
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
                                          hintText: AppLocalizations.of(
                                            context,
                                          )!.requiredPoints,
                                          controller: requiredPointsController,
                                        ),
                                        const SizedBox(height: 16),

                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.marketerPoints,
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
                                          hintText: AppLocalizations.of(
                                            context,
                                          )!.marketerPoints,
                                          controller: marketerPointsController,
                                        ),
                                        const SizedBox(height: 16),

                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.inspectorPoints,
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
                                          hintText: AppLocalizations.of(
                                            context,
                                          )!.inspectorPoints,
                                          controller: inspectorPointsController,
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
                                            if (value == null ||
                                                value == 'Choose Status') {
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
                                              AppLocalizations.of(
                                                context,
                                              )!.images,
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
                                                        AppLocalizations.of(
                                                          context,
                                                        )!.browseFiles,
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
                                              AppLocalizations.of(
                                                context,
                                              )!.description,
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
                                          AppLocalizations.of(
                                            context,
                                          )!.addProduct,
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
                                                  inspectorPoints: inspectorPointsController.text.trim(),
                                                  marketerPoints: marketerPointsController.text.trim(),
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
                                            CustomDialog.positiveButton(
                                              context: context,
                                              title: "Added",
                                              // you may define this key in your l10n
                                              message:
                                              "the products have  been Added successfully.",
                                              positiveText: "OK",
                                              positiveOnClick: () {
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          }

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
                                          AppLocalizations.of(context)!.cancel,
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
