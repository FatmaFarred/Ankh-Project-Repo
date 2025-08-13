import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../api_service/di/di.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../../core/validator/my_validator.dart';
import '../../email_verfication/email_verfication_screen.dart';
import '../../signin/signin_screen.dart';
import 'controller/reset_password_cubit.dart';
import 'controller/reset_password_states.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });

  final String email;
  final String token;
  static String resetPasswordScreenRouteName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPasswordCubit resetPassworsCubit = getIt<ResetPasswordCubit>();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    print('Initializing ResetPasswordScreen with:');
    print('Email: ${widget.email}');
    print('Token: ${widget.token}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
        bloc: resetPassworsCubit,
        listener: (context, state) {
          if (state is ResetPasswordLoading) {
            CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false);
          } else if (state is ResetPasswordFailure) {
            Navigator.of(context).pop();
            CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.error,
                message: state.errorMessage);
          } else if (state is ResetPasswordSuccess) {
            Navigator.of(context).pop();
            CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.message,
                positiveOnClick: () {
                  // Navigate to sign-in screen after successful password reset
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInScreen.signInScreenRouteName,
                    (route) => false,
                  );
                },
              );
          }
        },



        child:

     Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
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
                  child: Image.asset(ImageAssets.appIcon, height: 200.h),
                  backgroundColor: Colors.black,
                  radius: 35.r,
                ),
                SizedBox(height: 15.h),
                Text(
                  AppLocalizations.of(context)!.setNewPassword,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.setPasswordSubTitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    color: ColorManager.darkGrey,
                  ),
                ),
                SizedBox(height: 55.h),
                Text(
                  AppLocalizations.of(context)!.newPassword,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: resetPassworsCubit.passwordController,
                  hintText: AppLocalizations.of(context)!.enterNewPassword,
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
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.confirmPassword,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: resetPassworsCubit.confirmPasswordController,
                  hintText: AppLocalizations.of(context)!.reEnterNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: !_isConfirmPasswordVisible,
                  validator: (value) => ValidatorUtils.validateConfirmPassword(
                    resetPassworsCubit.passwordController.text,
                    context,
                    value,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: ColorManager.darkGrey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 40.h),
                CustomizedElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Call the reset password cubit
                      resetPassworsCubit.resetPassword(
                        widget.email,
                        widget.token,
                        resetPassworsCubit.passwordController.text,
                      );
                    }
                  },
                  borderColor: ColorManager.lightprimary,
                  color: ColorManager.lightprimary,
                  bottonWidget: Text(
                    AppLocalizations.of(context)!.resetPassword,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorManager.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
     )
    );
  }
}