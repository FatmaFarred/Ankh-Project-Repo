import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/validator/my_validator.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/feauture/request_inspection_screen/confirm_request_screen.dart';
import 'package:ankh_project/feauture/request_inspection_screen/confrim_requests_arg.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../api_service/di/di.dart';
import '../../data/models/add_inspection _request.dart';
import '../../domain/entities/installment_request_entity.dart';
import '../../domain/entities/price_offer_request_entity.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../dashboard/products_management/add_new_product/Custom_Tab_Bar.dart';
import '../inspector_screen/request_submitted_screen.dart';
import 'cubit/marketer_add_request_cubit.dart';
import 'cubit/states.dart';

class RequestInspectionScreen extends StatefulWidget {
  const RequestInspectionScreen({super.key});

  static String requestInspectionScreenRouteName = "RequestInspectionScreen";

  @override
  State<RequestInspectionScreen> createState() =>
      _RequestInspectionScreenState();
}

class _RequestInspectionScreenState extends State<RequestInspectionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool light = true;
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController timeController = TextEditingController();
  TimeOfDay? selectedTime;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController price = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController requestedMonthsController = TextEditingController();

  final TextEditingController downPaymentController = TextEditingController();
  final TextEditingController requestedPriceController =
      TextEditingController();
  int selectedTabIndex = 0;

  List<Widget> _buildTabContent(int index) {
    final user = context.watch<UserCubit>().state;
    final product =
        ModalRoute.of(context)?.settings.arguments as ProductDetailsEntity;
    final cubit = context.read<MarketerAddRequestCubit>();

    switch (index) {
      case 0: // "طلب معاينه"
        return [
          // Your current content (client name, phone, date, etc.)
          Text(
            AppLocalizations.of(context)!.clientName,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: nameController,
            hintText: AppLocalizations.of(context)!.enterClientName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidatorUtils.validateName(value, context),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.phoneNumber,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: phoneController,
            hintText: AppLocalizations.of(context)!.enterPhoneNumber,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidatorUtils.validatePhone(value, context),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.address,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: addressController,
            hintText: AppLocalizations.of(context)!.enterAddress,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidatorUtils.validateName(value, context),
          ),
          Text(
            AppLocalizations.of(context)!.price,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          CustomTextField(
            controller: price,
            hintText: AppLocalizations.of(context)!.price,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.fieldRequired;
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),

          Text(
            AppLocalizations.of(context)!.preferredDate,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.fieldRequired;
              }
              return null;
            },

            readOnly: true,
            onTap: () => pickDate(context),
            controller: dateController,
            hintText: AppLocalizations.of(context)!.datePlaceholder,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Color(0xffA3A3A3),
              size: 15.sp,
            ),
            suffixIcon: Icon(
              Icons.calendar_today_rounded,
              color: ColorManager.black,
              size: 15.sp,
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.preferredTime,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            onTap: () => pickTime(context),
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.fieldRequired;
              }
              return null;
            },

            controller: timeController,
            hintText: AppLocalizations.of(context)!.selectTimeSlot,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(
              Icons.watch_later_outlined,
              color: Color(0xffA3A3A3),
              size: 15.sp,
            ),
          ),
          SizedBox(height: 28.h),

          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.saveInfoForLater,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.black,
                ),
              ),
              Spacer(),
              Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: light,
                  activeColor: ColorManager.lightprimary,
                  onChanged: (bool value) {
                    setState(() {
                      light = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          CustomizedElevatedButton(
            bottonWidget: Text(
              AppLocalizations.of(context)!.next,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.white,
                fontSize: 16.sp,
              ),
            ),
            color: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            onPressed: () {
              print(user?.id);
              print(product?.id);
              if (_formKey.currentState!.validate()) {
                final request = InspectionRequest(
                  agreedPrice: price.text.isNotEmpty ? num.tryParse(price.text) ?? 0:0,
                  clientName: nameController.text,
                  phoneNumber: phoneController.text,
                  address: addressController.text,
                  preferredDate: selectedDate ?? DateTime.now(),
                  preferredTime: timeController.text,
                  marketerId: user?.id ?? "",
                  // get from UserCubit
                  productId: product?.id?.toInt() ?? 0,
                );

                Navigator.pushNamed(
                  context,
                  ConfirmRequestScreen.confirmRequestRouteName,
                  arguments: ConfirmRequestArgs(
                    product: product,
                    request: request,
                  ),
                );
              }
            },
          ),
          // ... continue with the rest of your form content here
        ];

      case 1: // "طلب عرض سعر"
        return [
          Text(
            AppLocalizations.of(context)!.clientName,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: nameController,
            hintText: AppLocalizations.of(context)!.enterClientName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidatorUtils.validateName(value, context),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.phoneNumber,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: phoneController,
            hintText: AppLocalizations.of(context)!.enterPhoneNumber,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidatorUtils.validatePhone(value, context),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.aggredPrice,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: requestedPriceController,
            hintText: AppLocalizations.of(context)!.price,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.required;
              }

              final parsed = double.tryParse(value.trim());
              if (parsed == null) {
                return "invalid Price";
              }

              if (parsed <= 0) {
                return "it should be more than zero";
              }

              return null;
            },
          ),
          SizedBox(height: 32.h),
          CustomizedElevatedButton(
            bottonWidget: Text(
              AppLocalizations.of(context)!.next,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.white,
                fontSize: 16.sp,
              ),
            ),
            color: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final request = PriceOfferRequestEntity(
                  marketerId: user?.id ?? '',
                  productId: product?.id?.toInt() ?? 0,
                  clientName: nameController.text.trim(),
                  clientPhone: phoneController.text.trim(),
                  requestedPrice: int.parse(
                    requestedPriceController.text.trim(),
                  ),
                );
                print("clicked");

                final result = await context
                    .read<MarketerAddRequestCubit>()
                    .sendPriceOfferRequest(request);
                result.fold(
                  (failure) {
                    print(
                      '❌ Price Offer Request failed: ${failure.errorMessage.toString()}',
                    );
                    CustomDialog.positiveButton(
                      context: context,
                      title: AppLocalizations.of(context)!.failedToLoadData,
                      message: "Price Offer Request failed",
                      positiveOnClick: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                  (_) {
                    print('✅ Price Offer Request sent successfully!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RequestSubmittedScreen();
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ];

      case 2: // "طلب عرض تقسيط"
        return [
          Text(
            AppLocalizations.of(context)!.clientName,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: nameController,
            hintText: AppLocalizations.of(context)!.enterClientName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidatorUtils.validateName(value, context),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.phoneNumber,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: phoneController,
            hintText: AppLocalizations.of(context)!.enterPhoneNumber,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidatorUtils.validatePhone(value, context),
          ),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.price,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: requestedPriceController,
            hintText: AppLocalizations.of(context)!.price,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.required;
              }

              final parsed = double.tryParse(value.trim());
              if (parsed == null) {
                return "invalid Price";
              }

              if (parsed <= 0) {
                return "it should be more than zero";
              }

              return null;
            },
          ),
          SizedBox(height: 16.h),
          Text(
            "عدد الشهور",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: requestedMonthsController,
            hintText: "عدد الشهور",
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.required;
              }

              final parsed = double.tryParse(value.trim());
              if (parsed == null) {
                return "invalid";
              }

              if (parsed <= 0) {
                return "it should be more than zero";
              }

              return null;
            },
          ),
          SizedBox(height: 16.h),
          Text(
            "المقدم",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextField(
            controller: downPaymentController,
            hintText: "المقدم",
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.required;
              }

              final parsed = double.tryParse(value.trim());
              if (parsed == null) {
                return "invalid";
              }

              if (parsed <= 0) {
                return "it should be more than zero";
              }

              return null;
            },
          ),
          SizedBox(height: 32.h),
          CustomizedElevatedButton(
            bottonWidget: Text(
              AppLocalizations.of(context)!.next,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.white,
                fontSize: 16.sp,
              ),
            ),
            color: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final request = InstallmentRequestEntity(
                  marketerId: user?.id ?? "",
                  productId: product?.id?.toInt() ?? 0,
                  clientName: nameController.text,
                  clientPhone: phoneController.text,
                  installmentPeriod: int.tryParse(requestedMonthsController.text) ?? 0,
                  downPayment: int.tryParse(downPaymentController.text) ?? 0,
                );
                print("clicked");

                final result = await context
                    .read<MarketerAddRequestCubit>()
                    .sendInstallmentRequest(request);
                  result.fold(
                        (failure) {
                      print(
                        '❌ Price Offer Request failed: ${failure.errorMessage.toString()}',
                      );
                      CustomDialog.positiveButton(
                        context: context,
                        title: AppLocalizations.of(context)!.failedToLoadData,
                        message: "Price Offer Request failed",
                        positiveOnClick: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                        (_) {
                      print('✅ Price Offer Request sent successfully!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RequestSubmittedScreen();
                          },
                        ),
                      );
                    },
                  );
                }
              }
          ),
        ];

      default:
        return [const SizedBox()];
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final product =
        ModalRoute.of(context)?.settings.arguments as ProductDetailsEntity?;

    if (product == null) {
      print("product is null, returning empty widget");
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (context) => getIt<MarketerAddRequestCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<MarketerAddRequestCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(CupertinoIcons.back),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(AppLocalizations.of(context)!.requestInspection),
              centerTitle: true,
              backgroundColor: ColorManager.lightprimary,
              titleTextStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: REdgeInsets.symmetric(vertical: 24.0, horizontal: 20),
                child:
                    BlocListener<
                      MarketerAddRequestCubit,
                      MarketerAddRequestState
                    >(
                      listener: (context, state) {
                        if (state is PriceOfferRequestSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RequestSubmittedScreen(),
                            ),
                          );
                        } else if (state is PriceOfferRequestError) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: CustomTabBar(
                                tabs: [
                                  "طلب معاينه",
                                  "طلب عرض سعر",
                                  "طلب عرض تقسيط",
                                ],
                                onTabChanged: (index) {
                                  setState(() {
                                    selectedTabIndex = index;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            ..._buildTabContent(selectedTabIndex),
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      print(dateController.text);
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      selectedTime = picked;
      final now = DateTime.now();

      final formattedTime = DateFormat('HH:mm:ss').format(
        DateTime(now.year, now.month, now.day, picked.hour, picked.minute),
      );
      timeController.text = formattedTime;
      print(timeController.text);
    }
  }
}

Widget _buildContentForTab(int index) {
  switch (index) {
    case 0:
      return const Center(child: Text("📋 محتوى طلب معاينه"));
    case 1:
      return const Center(child: Text("💸 محتوى طلب عرض سعر"));
    case 2:
      return const Center(child: Text("🏦 محتوى طلب عرض تقسيط"));
    default:
      return const SizedBox.shrink();
  }
}
