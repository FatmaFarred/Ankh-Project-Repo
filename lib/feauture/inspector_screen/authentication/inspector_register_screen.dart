import 'dart:io';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api_service/di/di.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../core/validator/my_validator.dart';
import '../../authentication/email_verfication/email_verfication_screen.dart';
import '../../authentication/signin/signin_screen.dart';
import '../../welcome_screen/welcome_screen.dart';
import 'inspector_register_controller/inspector_register_cubit.dart';
import 'inspector_register_controller/inspector_register_states.dart';

class InspectorRegisterScreen extends StatefulWidget {
  const InspectorRegisterScreen({super.key});
  static String inspectorRegisterScreenRouteName = "InspectorRegisterScreen";

  @override
  State<InspectorRegisterScreen> createState() => _InspectorRegisterScreenState();
}

class _InspectorRegisterScreenState extends State<InspectorRegisterScreen> {
  InspectorRegisterCubit inspectorRegisterCubit = getIt<InspectorRegisterCubit>();
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  Future<void> _pickImage(bool isLicenseImage) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (isLicenseImage) {
        inspectorRegisterCubit.setLicenseImage(File(image.path));
      } else {
        inspectorRegisterCubit.setVehicleImage(File(image.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InspectorRegisterCubit, InspectorRegisterState>(
      bloc: inspectorRegisterCubit,
      listener: (context, state) {
        if (state is InspectorRegisterLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is InspectorRegisterFailure) {
          Navigator.of(context).pop();
          CustomDialog.positiveAndNegativeButton(
            context: context,
            positiveText: AppLocalizations.of(context)!.tryAgain,
            positiveOnClick: () {
              Navigator.of(context).pop();
              inspectorRegisterCubit.registerInspector();
            },
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage,
          );
        } else if (state is InspectorRegisterSuccess) {
          Navigator.of(context).pop();
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.response.message,
            positiveOnClick: () => Navigator.of(context).pushNamed(
              SignInScreen.signInScreenRouteName
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context,
                  WelcomeScreen.welcomeScreenRouteName
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.37.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      ImageAssets.appIcon,
                      height: 200.h,
                    ),
                    backgroundColor: Colors.black,
                    radius: 35.r,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    AppLocalizations.of(context)!.createAccount,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 24.sp),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    AppLocalizations.of(context)!.registerSubTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
                  ),
                  SizedBox(height: 55.h),
                  
                  // Full Name
                  Text(
                    AppLocalizations.of(context)!.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.fullNameController,
                    hintText: AppLocalizations.of(context)!.enterYourName,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) => ValidatorUtils.validateName(value, context),
                  ),
                  SizedBox(height: 20.h),
                  
                  // Phone Number
                  Text(
                    AppLocalizations.of(context)!.phoneNumber,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.phoneController,
                    hintText: AppLocalizations.of(context)!.enterYourPhone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) => ValidatorUtils.validatePhone(value, context),
                  ),
                  SizedBox(height: 20.h),
                  
                  // Email
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.emailController,
                    hintText: AppLocalizations.of(context)!.enterYourName,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) => ValidatorUtils.validateEmail(value, context),
                  ),
                  SizedBox(height: 20.h),
                  
                  // License Number
                  Text(
                    AppLocalizations.of(context)!.licenseNumber,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.licenseNumberController,
                    hintText: AppLocalizations.of(context)!.enterLicenseNumber,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value?.isEmpty == true ? AppLocalizations.of(context)!.fieldRequired : null,
                  ),
                  SizedBox(height: 20.h),
                  
                  // Vehicle License Number
                  Text(
                    AppLocalizations.of(context)!.vehicleLicenseNumber,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.vehicleLicenseNumberController,
                    hintText: AppLocalizations.of(context)!.enterVehicleLicenceNumber,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value?.isEmpty == true ? AppLocalizations.of(context)!.fieldRequired: null,
                  ),
                  SizedBox(height: 20.h),
                  
                  // Work Area
                  Text(
                    AppLocalizations.of(context)!.workArea,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.workAreaController,
                    hintText:AppLocalizations.of(context)!.enterWorkArea,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value?.isEmpty == true ?  AppLocalizations.of(context)!.fieldRequired : null,
                  ),
                  SizedBox(height: 20.h),
                  
                  // Vehicle Type
                  Text(
                    AppLocalizations.of(context)!.vehicleType,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.vehicleTypeController,
                    hintText:AppLocalizations.of(context)!.enterVehicleType,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value?.isEmpty == true ?  AppLocalizations.of(context)!.fieldRequired : null,
                  ),
                  SizedBox(height: 20.h),
                  
                  // License Image Upload
                  Text(
                    AppLocalizations.of(context)!.licenseImage,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () => _pickImage(true),
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.lightGrey),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: BlocBuilder<InspectorRegisterCubit, InspectorRegisterState>(
                        bloc: inspectorRegisterCubit,
                        builder: (context, state) {
                          if (inspectorRegisterCubit.licenseImage != null) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                inspectorRegisterCubit.licenseImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 40, color: ColorManager.darkGrey),
                                SizedBox(height: 8.h),
                                Text(
                                  AppLocalizations.of(context)!.uploadLicenseImage,
                                  style: TextStyle(color: ColorManager.darkGrey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // License Image Validation
                  BlocBuilder<InspectorRegisterCubit, InspectorRegisterState>(
                    bloc: inspectorRegisterCubit,
                    builder: (context, state) {
                      if (inspectorRegisterCubit.licenseImage == null &&
                          inspectorRegisterCubit.showLicenseImageError) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            AppLocalizations.of(context)!.fieldRequired,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Vehicle Image Upload
                  Text(
                      AppLocalizations.of(context)!.vehicleImage,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () => _pickImage(false),
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.lightGrey),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: BlocBuilder<InspectorRegisterCubit, InspectorRegisterState>(
                        bloc: inspectorRegisterCubit,
                        builder: (context, state) {
                          if (inspectorRegisterCubit.vehicleImage != null) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                inspectorRegisterCubit.vehicleImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 40, color: ColorManager.darkGrey),
                                SizedBox(height: 8.h),
                                Text(
                                  AppLocalizations.of(context)!.uploadVehicleImage,
                                  style: TextStyle(color: ColorManager.darkGrey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Vehicle Image Validation
                  BlocBuilder<InspectorRegisterCubit, InspectorRegisterState>(
                    bloc: inspectorRegisterCubit,
                    builder: (context, state) {
                      if (inspectorRegisterCubit.vehicleImage == null &&
                          inspectorRegisterCubit.showVehicleImageError) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            AppLocalizations.of(context)!.fieldRequired,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Password
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: inspectorRegisterCubit.passwordController,
                    hintText: AppLocalizations.of(context)!.enterYourPassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: !_isPasswordVisible,
                    validator: (value) => ValidatorUtils.validatePassword(value, context),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: ColorManager.darkGrey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),

                  CustomizedElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        inspectorRegisterCubit.registerInspector();
                      }
                    },
                    borderColor: ColorManager.lightprimary,
                    color: ColorManager.lightprimary,
                    bottonWidget: Text(
                      AppLocalizations.of(context)!.register,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: ColorManager.white, fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAccount,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            SignInScreen.signInScreenRouteName,
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.loginNow,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 14.sp, color: ColorManager.lightprimary),
                        ),
                      ),
                    ],
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