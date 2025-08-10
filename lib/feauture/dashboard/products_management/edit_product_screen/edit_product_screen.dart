
import 'dart:io';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/product_name_entity.dart';
import 'package:ankh_project/domain/entities/product_post_entity.dart';
import 'package:ankh_project/domain/entities/top_brand_entity.dart';
import 'package:ankh_project/feauture/home_screen/top_brands/cubit/top_brand_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/di/di.dart';
import '../../../../core/constants/font_manager/font_manager.dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../../data/models/used_details_model.dart';
import '../../../../domain/entities/product_management_entity.dart';
import '../../../../domain/entities/used_details_entity.dart';
import '../../../../domain/use_cases/edit_product_usecase.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../inspector_screen/widgets/custom_text_form_field.dart';
import '../../dashboard_main screen _drawer/dashboard_main_screen _drawer.dart';
import '../../products_management/cubit/product_names_dropdown_cubit.dart';
import 'edit_product_cubit.dart';

class EditProductScreen extends StatefulWidget {
  final ProductManagementEntity product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String? selectedTransmission = 'Choose Transmission Type';
  String? selectedFuel = 'Choose Fuel Type';
  String? selectedMarketer = 'Mohamed Khaled';
  String? selectedStatus = 'Choose Status';
  String? selectedDriveType = 'Choose Drive Type';
  String? selectedCarName;
  int? selectedProductId; // Added to store the product ID
  TopBrandEntity? selectedTopBrand;
  
  late ProductNamesDropdownCubit _productNamesDropdownCubit;

  late List<String> imageUrls;
  List<XFile> selectedImages = []; // Add this for new selected images


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

  XFile? _selectedlicenseImage;
  XFile? _selectedinsuranceFrontPath ;
  XFile? _selectedInsuranceBackPath;

  void pickSingleImage({required Function(XFile?) onImagePicked}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    onImagePicked(image);
  }

  // Add new method for picking multiple images
  void pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        selectedImages.addAll(images);
      });
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

  late final TextEditingController carNameController;
  late final TextEditingController categoryController;
  late final TextEditingController yearController;
  late final TextEditingController odometerController;
  late final TextEditingController colorController;
  late final TextEditingController ownerNameController;
  late final TextEditingController locationController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;
  late final TextEditingController commissionController;
  late final TextEditingController requiredPointsController;
  late final TextEditingController horsepowerController;
  late final TextEditingController batteryCapacityController;
  late final TextEditingController licenseExpiryDateController;
  late final TextEditingController safetyReportController;
  late final TextEditingController interiorConditionController;
  late final TextEditingController exteriorConditionController;
  late final TextEditingController additionalSpecsController;
  late final TextEditingController additionalInfoController;
  late final TextEditingController paymentMethodController;
  late final TextEditingController inspectionResultController;
  late final TextEditingController accidentHistoryController;
  late final TextEditingController testDriveAvailableController;
  late final TextEditingController warrantyStatusController;
  late final TextEditingController tireStatusController;
  late final TextEditingController lightStatusController;
  late final TextEditingController licenseDurationController;
  late final TextEditingController trafficViolationsController;
  late final TextEditingController insuranceStatusController;
  late final TextEditingController numberOfKeysController;
  late final TextEditingController seatConditionController;
  late final TextEditingController brakesConditionController;
  late final TextEditingController gearConditionController;
  late final TextEditingController driveSystemConditionController;
  late final TextEditingController tagsController;
  late final TextEditingController safetyStatusController;
  late final TextEditingController taxStatusController;
  late final TextEditingController marketerPointsController;
  late final TextEditingController inspectorPointsController;


  @override
  void initState() {
    super.initState();
    // Initialize product names dropdown cubit
    _productNamesDropdownCubit = getIt<ProductNamesDropdownCubit>();
    _productNamesDropdownCubit.loadProductNames();
    
    // Fetch top brands when the widget initializes
    context.read<TopBrandCubit>().fetchTopBrands();

    print('🧾 Product: ${widget.product}');
    print('🧾 Used Details: ${widget.product.usedDetails}');

    // Or print specific fields
    print('Title: ${widget.product.title}');
    print('Mileage: ${widget.product.mileage}');
    print('Used owner: ${widget.product.usedDetails?.ownerName}');

    // Set selectedCarName from product title
    selectedCarName = widget.product.title;
    
    // We'll set the selectedProductId when the product names are loaded
    _productNamesDropdownCubit.stream.listen((state) {
      if (state is ProductNamesDropdownLoaded) {
        // Check if the product title is a numeric value (product ID)
        if (widget.product.title.trim().isNotEmpty && int.tryParse(widget.product.title) != null) {
          // If the title is a numeric value, find the product name by ID
          final productId = int.parse(widget.product.title);
          final matchingProduct = state.productNames.firstWhere(
            (product) => product.id == productId,
            orElse: () => ProductNameEntity(id: 0, name: ''),
          );
          
          if (matchingProduct.id != 0) {
            setState(() {
              selectedProductId = matchingProduct.id;
              selectedCarName = matchingProduct.name;
              carNameController.text = matchingProduct.name;
            });
          }
        } else {
          // If the title is not a numeric value, try to find by name as before
          final matchingProduct = state.productNames.firstWhere(
            (product) => product.name == widget.product.title,
            orElse: () => ProductNameEntity(id: 0, name: ''),
          );
          
          if (matchingProduct.id != 0) {
            setState(() {
              selectedProductId = matchingProduct.id;
            });
          }
        }
      }
    });

    carNameController = TextEditingController(text: widget.product.title);
    marketerPointsController = TextEditingController(text: widget.product.marketerPoints.toString());
    inspectorPointsController = TextEditingController(text: widget.product.inspectorPoints.toString());
    categoryController =
        TextEditingController(text: widget.product.category);
    yearController =
        TextEditingController(text: widget.product.year.toString());
    odometerController =
        TextEditingController(text: widget.product.mileage.toString());
    colorController = TextEditingController(text: widget.product.color);
    ownerNameController = TextEditingController(
        text: widget.product.usedDetails?.ownerName);
    locationController =
        TextEditingController(text: widget.product.usedDetails?.address);
    priceController =
        TextEditingController(text: widget.product.price.toString());
    descriptionController =
        TextEditingController(text: widget.product.description.toString());
    commissionController =
        TextEditingController(text: widget.product.commission.toString());
    requiredPointsController = TextEditingController(
        text: widget.product.requiredPoints.toString());
    horsepowerController = TextEditingController(
        text: widget.product.horsepower.toString());
    batteryCapacityController = TextEditingController(
        text: widget.product.batteryCapacity.toString());
    licenseExpiryDateController = TextEditingController(text: widget.product.usedDetails?.licenseExpiryDate.toString() ?? '');
    safetyReportController = TextEditingController(
        text: widget.product.usedDetails?.safetyReport ?? '');
    interiorConditionController = TextEditingController(
        text: widget.product.usedDetails?.interiorCondition ?? '');
    exteriorConditionController = TextEditingController(
        text: widget.product.usedDetails?.exteriorCondition ?? '');
    additionalSpecsController = TextEditingController(
        text: widget.product.usedDetails?.additionalSpecs ?? '');
    additionalInfoController = TextEditingController(
        text: widget.product.usedDetails?.additionalInfo ?? '');
    paymentMethodController = TextEditingController(
        text: widget.product.usedDetails?.paymentMethod ?? '');
    inspectionResultController = TextEditingController(
        text: widget.product.usedDetails?.inspectionResult ?? '');
    accidentHistoryController = TextEditingController(
        text: widget.product.usedDetails?.accidentHistory ?? '');
    testDriveAvailableController = TextEditingController(
        text: widget.product.usedDetails?.testDriveAvailable.toString() ?? '');
    warrantyStatusController = TextEditingController(
        text: widget.product.usedDetails?.warrantyStatus ?? '');
    tireStatusController = TextEditingController(
        text: widget.product.usedDetails?.tireStatus ?? '');
    lightStatusController = TextEditingController(
        text: widget.product.usedDetails?.lightStatus ?? '');
    licenseDurationController = TextEditingController(
        text: widget.product.usedDetails?.licenseDuration ?? '');
    trafficViolationsController = TextEditingController(
        text: widget.product.usedDetails?.trafficViolations ?? '');
    insuranceStatusController = TextEditingController(
        text: widget.product.usedDetails?.insuranceStatus ?? '');
    numberOfKeysController = TextEditingController(
        text: widget.product.usedDetails?.numberOfKeys ?? '');
    seatConditionController = TextEditingController(
        text: widget.product.usedDetails?.seatCondition ?? '');
    brakesConditionController = TextEditingController(
        text: widget.product.usedDetails?.brakesCondition ?? '');
    gearConditionController = TextEditingController(
        text: widget.product.usedDetails?.gearCondition ?? '');
    driveSystemConditionController = TextEditingController(
        text: widget.product.usedDetails?.driveSystemCondition ?? '');
    tagsController = TextEditingController(text: widget.product.usedDetails?.tags ?? '');
    safetyStatusController = TextEditingController(text: widget.product.usedDetails?.safetyStatus ?? '');
    taxStatusController = TextEditingController(text: widget.product.usedDetails?.taxStatus ?? '');
    selectedTransmission = widget.product.transmission;
    selectedFuel = widget.product.fuelType;
    selectedStatus = widget.product.status;
    selectedDriveType = widget.product.driveType;
    imageUrls = widget.product.imageUrls;
    
    // Initialize statusNum based on the product's current status
    if (widget.product.status == "Available") {
      statusNum = 1;
    } else if (widget.product.status == "Sold") {
      statusNum = 2;
    } else if (widget.product.status == "Reserved") {
      statusNum = 3;
    } else {
      statusNum = 1; // Default to Available if status is not recognized
    }
  }

  @override
  void dispose() {
    _productNamesDropdownCubit.close();
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
    requiredPointsController.dispose();
    horsepowerController.dispose();
    batteryCapacityController.dispose();
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
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProductCubit(getIt<EditProductUseCase>()),
      child: BlocListener<EditProductCubit, EditProductState>(
          listener: (context, state) {
            if (state is EditProductSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardMainScreen()),
              );
            } else if (state is EditProductFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child:Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.editCarDetails),
        backgroundColor: ColorManager.lightprimary,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
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
                        BlocBuilder<ProductNamesDropdownCubit, ProductNamesDropdownState>(
                          bloc: _productNamesDropdownCubit,
                          builder: (context, state) {
                            if (state is ProductNamesDropdownLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is ProductNamesDropdownError) {
                              return Text('Error: ${state.message}', style: TextStyle(color: Colors.red));
                            } else if (state is ProductNamesDropdownLoaded) {
                              final productNames = state.productNames;
                              
                              return DropdownButtonFormField<int>(
                                value: selectedProductId,
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
                                  if (value == null) {
                                    return AppLocalizations.of(context)!.carNameRequired;
                                  }
                                  return null;
                                },
                                items: productNames.map((product) {
                                  return DropdownMenuItem<int>(
                                    value: product.id,
                                    child: Text(product.name),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedProductId = newValue;
                                    // Find the product name from the selected ID
                                    final selectedProduct = productNames.firstWhere(
                                      (product) => product.id == newValue,
                                      orElse: () => ProductNameEntity(id: 0, name: ''),
                                    );
                                    selectedCarName = selectedProduct.name;
                                    carNameController.text = selectedProduct.name;
                                  });
                                },
                              );
                            } else {
                              return DropdownButtonFormField<String>(
                                value: selectedCarName,
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.carName,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: ColorManager.lightGrey),
                                  ),
                                ),
                                items: const [],
                                onChanged: null,
                              );
                            }
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
                              
                              // If we have a topBrandName from the product and selectedTopBrand is not set yet,
                              // find the matching brand by name
                              if (widget.product.topBrandName != null && selectedTopBrand == null) {
                                for (var brand in brands) {
                                  if (brand.name == widget.product.topBrandName) {
                                    // Use Future.microtask to avoid setState during build
                                    Future.microtask(() {
                                      setState(() {
                                        selectedTopBrand = brand;
                                      });
                                    });
                                    break;
                                  }
                                }
                              }
                              
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.category,
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
                                        return AppLocalizations.of(context)!.required;
                                      }
                                      return null;
                                    },
                                    hintText: AppLocalizations.of(context)!.category,
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
                                    AppLocalizations.of(context)!.year,
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
                                        return AppLocalizations.of(context)!.required;
                                      }
                                      return null;
                                    },
                                    keyBoardType:
                                    TextInputType.number,
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.mileage,
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
                                        return AppLocalizations.of(context)!.required;
                                      }
                                      return null;
                                    },
                                    keyBoardType:
                                    TextInputType.number,
                                    hintText: AppLocalizations.of(context)!.mileage,
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
                                    AppLocalizations.of(context)!.color,
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
                                        return AppLocalizations.of(context)!.required;
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.horsePower,
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
                                        return AppLocalizations.of(context)!.required;
                                      }
                                      return null;
                                    },
                                    keyBoardType:
                                    TextInputType.number,
                                    hintText: AppLocalizations.of(context)!.horsePower,
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
                                    AppLocalizations.of(context)!.batteryCapacity,
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
                                        return AppLocalizations.of(context)!.required;
                                      }
                                      return null;
                                    },
                                    keyBoardType:
                                    TextInputType.number,
                                    hintText:
                                    AppLocalizations.of(context)!.batteryCapacity,
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
                              AppLocalizations.of(context)!.specifications,
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

                widget.product.isUsedVehicle == false ? SizedBox() : SizedBox(height: 16.h),
                widget.product.isUsedVehicle == false ? SizedBox() : Card(
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
                          AppLocalizations.of(context)!.ownerName,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextFormField(hintText: AppLocalizations.of(context)!.ownerName,controller: ownerNameController,),
                        const SizedBox(height: 16),

                        Text(
                          AppLocalizations.of(context)!.location,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextFormField(
                          hintText: AppLocalizations.of(context)!.location,
                          controller: locationController,
                        ),
                        const SizedBox(height: 16),

                        // Fuel Type Dropdown
                        // Text(
                        //   'Assigned Marketer',
                        //   style: GoogleFonts.inter(
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeightManager.semiBold,
                        //   ),
                        // ),
                        // const SizedBox(height: 8),
                        // DropdownButtonFormField<String>(
                        //   iconSize: 20.sp,
                        //   style: GoogleFonts.inter(
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeightManager.semiBold,
                        //     color: ColorManager.black,
                        //   ),
                        //   value: selectedMarketer,
                        //   items: marketers
                        //       .map(
                        //         (type) =>
                        //         DropdownMenuItem(
                        //           value: type,
                        //           child: Text(type),
                        //         ),
                        //   )
                        //       .toList(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       selectedMarketer = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Colors.grey.shade100,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(16),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),

                widget.product.isUsedVehicle == false ? SizedBox() : Card(
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
                          hintText: AppLocalizations.of(context)!.taxStatus,
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
                widget.product.isUsedVehicle == false ? SizedBox() : SizedBox(height: 16.h),

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
                              return AppLocalizations.of(context)!.required;
                            }
                            return null;
                          },
                          keyBoardType:
                          TextInputType.numberWithOptions(),
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
                            if (value == null ||
                                value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            }
                            return null;
                          },
                          keyBoardType:
                          TextInputType.numberWithOptions(),
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
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            }
                            return null;
                          },
                          keyBoardType:
                          TextInputType.numberWithOptions(),
                          hintText: AppLocalizations.of(context)!.requiredPoints,
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
                              AppLocalizations.of(context)!.images,
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeightManager.semiBold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        imageUrls.isEmpty && selectedImages.isEmpty
                            ? SizedBox()
                            : SizedBox(
                          height: 120.h,
                          child: ListView.separated(
                            scrollDirection:
                            Axis.horizontal,
                            itemCount:
                            imageUrls.length + selectedImages.length,
                            itemBuilder: (context, index) {
                              if (index < imageUrls.length) {
                                // Show old images
                                return ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                      8.r,
                                    ),
                                    child:
                                    Image.network(
                                      "https://ankhapi.runasp.net/${imageUrls[index]}",
                                      width: 120.w,
                                      height: 120.h,
                                      fit: BoxFit.cover, 
                                      errorBuilder:(context, error, stackTrace) {
                                        return Container(
                                          width: 120.w,
                                          height: 120.h,
                                          color: Colors.grey[300],
                                          child: Icon(Icons.broken_image, color: Colors.grey),
                                        );
                                      }
                                    )
                                );
                              } else {
                                // Show new selected images
                                final newImageIndex = index - imageUrls.length;
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.file(
                                        File(selectedImages[newImageIndex].path),
                                        width: 120.w,
                                        height: 120.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedImages.removeAt(newImageIndex);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                            separatorBuilder: (_, _) =>
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
                                        AppLocalizations.of(context)!.browseFiles,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                          fontSize: 16.sp,
                                          color:
                                          ColorManager
                                              .white,
                                        ),
                                      ),
                                      onPressed: pickMultipleImages,
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

                widget.product.isUsedVehicle == false ? SizedBox() :Card(
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
                              AppLocalizations.of(context)!.licenseImages,
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
                widget.product.isUsedVehicle == false ? SizedBox() :SizedBox(height: 16.h),

                widget.product.isUsedVehicle == false ? SizedBox() :Card(
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
                              "Insurance Front ",
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
                widget.product.isUsedVehicle == false ? SizedBox() :SizedBox(height: 16.h),

                widget.product.isUsedVehicle == false ? SizedBox() :Card(
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
                              "Insurance Back",
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
                widget.product.isUsedVehicle == false ? SizedBox() :SizedBox(height: 16.h),

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
                        CustomTextFormField(
                          controller: descriptionController,
                          hintText:
                          "Clean car, no accidents, excellent condition",
                          maxLines: 4,
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
                          AppLocalizations.of(context)!.saveEdits,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                            fontSize: 16.sp,
                            color: ColorManager.white,
                          ),
                        ),
                        onPressed: () {

                          final usedDetailsEntity = UsedDetailsEntity(
                            ownerName: ownerNameController.text.trim(),
                            address: locationController.text.trim(),
                            licenseImage: _selectedlicenseImage.toString(),
                            insuranceCardFront: _selectedinsuranceFrontPath.toString(),
                            insuranceCardBack: _selectedInsuranceBackPath.toString(),
                            licenseExpiryDate: DateTime.tryParse(licenseExpiryDateController.text),
                            safetyReport: safetyReportController.text.trim(),
                            taxStatus: taxStatusController.text.trim(),
                            interiorCondition: interiorConditionController.text.trim(),
                            exteriorCondition: exteriorConditionController.text.trim(),
                            additionalSpecs: additionalSpecsController.text.trim(),
                            additionalInfo: additionalInfoController.text.trim(),
                            paymentMethod: paymentMethodController.text.trim(),
                            inspectionResult: inspectionResultController.text.trim(),
                            accidentHistory: accidentHistoryController.text.trim(),
                            testDriveAvailable: true,
                            warrantyStatus: warrantyStatusController.text.trim(),
                            tireStatus: tireStatusController.text.trim(),
                            lightStatus: lightStatusController.text.trim(),
                            safetyStatus: safetyStatusController.text.trim(),
                            licenseDuration: licenseDurationController.text.trim(),
                            trafficViolations: trafficViolationsController.text.trim(),
                            insuranceStatus: insuranceStatusController.text.trim(),
                            numberOfKeys: numberOfKeysController.text.trim(),
                            seatCondition: seatConditionController.text.trim(),
                            gearCondition: gearConditionController.text.trim(),
                            driveSystemCondition: driveSystemConditionController.text.trim(),
                            brakesCondition: brakesConditionController.text.trim(),
                            tags: tagsController.text.trim(),
                          );

                          final usedDetailsModel =    UsedDetailsModel.fromEntity(usedDetailsEntity);
                          final usedDetailsJson = usedDetailsModel.toJson();


                          final updatedProduct = ProductPostEntity(
                            nameProductId: selectedProductId?.toString() ?? carNameController.text.trim(),
                            description: descriptionController.text.trim(),
                            commission: commissionController.text,
                            inspectorPoints: inspectorPointsController.text.trim(),
                            marketerPoints: marketerPointsController.text.trim(),
                            requiredPoints: requiredPointsController.text,
                            make: statusNum.toString(),
                            model: yearController.text.trim(),
                            category: categoryController.text.trim(),
                            year: yearController.text.trim(),
                            mileage: odometerController.text.trim(),
                            color: colorController.text.trim(),
                            isUsedVehicle: widget.product.isUsedVehicle,
                            status: selectedStatus!,
                            price: priceController.text.trim(),
                            rating: "0",
                            transmission: selectedTransmission!,
                            fuelType: selectedFuel!,
                            driveType: selectedDriveType!,
                            engineType: selectedFuel!,
                            horsepower: horsepowerController.text.trim(),
                            topBrandId: selectedTopBrand?.id.toString() ?? '1',
                            batteryCapacity: batteryCapacityController.text.trim(),
                            videoPath: [],
                            images: _createCombinedImageList(),
                            usedDetails: usedDetailsJson,
                            // Pass the product ID as a string in the title field
                            // The title is still stored in carNameController.text for display purposes
                          );

                          print('--- Updated Product ---');
                          print('Title: ${updatedProduct.nameProductId}');
                          print('Description: ${updatedProduct.description}');
                          print('Commission: ${updatedProduct.commission}');
                          print('Required Points: ${updatedProduct.requiredPoints}');
                          print('Make: ${updatedProduct.make}');
                          print('Model: ${updatedProduct.model}');
                          print('Category: ${updatedProduct.category}');
                          print('Year: ${updatedProduct.year}');
                          print('Mileage: ${updatedProduct.mileage}');
                          print('Color: ${updatedProduct.color}');
                          print('Is Used Vehicle: ${updatedProduct.isUsedVehicle}');
                          print('Status: ${updatedProduct.status}');
                          print('Price: ${updatedProduct.price}');
                          print('Rating: ${updatedProduct.rating}');
                          print('Transmission: ${updatedProduct.transmission}');
                          print('Fuel Type: ${updatedProduct.fuelType}');
                          print('Drive Type: ${updatedProduct.driveType}');
                          print('Engine Type: ${updatedProduct.engineType}');
                          print('Horsepower: ${updatedProduct.horsepower}');
                          print('Top Brand ID: ${updatedProduct.topBrandId}');
                          print('Battery Capacity: ${updatedProduct.batteryCapacity}');
                          print('Video Path: ${updatedProduct.videoPath}');
                          print('Images: ${updatedProduct.images}');
                          print('Used Details JSON: $usedDetailsJson');

                          context.read<EditProductCubit>().editProduct(productId:widget.product.id, entity:updatedProduct);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardMainScreen()
                            ),
                          );

                          CustomDialog.positiveButton(
                            context: context,
                            title: AppLocalizations.of(context)!.edited,
                            message: AppLocalizations.of(context)!.editedSuccessfully,
                            positiveText: AppLocalizations.of(context)!.ok,
                            positiveOnClick: () {
                              Navigator.of(context).pop();
                            },
                          );

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
                          style: Theme
                              .of(context)
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
          ),
        ),
      ),
    )));
  }

  /// Creates a combined list of image paths for submission
  /// Old images are kept as relative paths (as they come from the backend)
  /// New images are added as absolute file paths
  List<String> _createCombinedImageList() {
    List<String> combinedList = [];
    
    // Add old images (keep them as relative paths)
    combinedList.addAll(imageUrls);
    
    // Add new images (as absolute file paths)
    combinedList.addAll(selectedImages.map((image) => image.path));
    
    print('--- Combined Image List ---');
    print('Old images count: ${imageUrls.length}');
    print('New images count: ${selectedImages.length}');
    print('Total images: ${combinedList.length}');
    print('Old images: $imageUrls');
    print('New images: ${selectedImages.map((image) => image.path).toList()}');
    print('Combined list: $combinedList');
    
    return combinedList;
  }
}
