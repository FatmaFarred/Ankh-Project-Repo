import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/validator/my_validator.dart';
import '../email_verfication/email_verfication_screen.dart';
import '../signin/signin_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String registerScreenRouteName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
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
                  child: Image.asset(
                    ImageAssets.appIcon,
                    height: 200.h,
                  ),
                  backgroundColor: Colors.black,
                  radius: 35.r,
                ),
                SizedBox(height: 15.h),
                Text(
                  AppLocalizations.of(context)!.register,
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
                Text(
                  AppLocalizations.of(context)!.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: fullNameController,
                  hintText: AppLocalizations.of(context)!.enterYourName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: ValidatorUtils.validateName,
                ),
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.phoneNumber,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: phoneController,
                  hintText: AppLocalizations.of(context)!.enterYourPhone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: ValidatorUtils.validatePhone,
                ),
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.enterYourName,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: ValidatorUtils.validateEmail,
                ),
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.password,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: passwordController,
                  hintText: AppLocalizations.of(context)!.enterYourPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: !_isPasswordVisible,
                  validator:
                  ValidatorUtils.validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: ColorManager.darkGrey
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
                        // Handle registration logic here
                        Navigator.of(context).pushNamed(EmailVerficationScreen.emailVerficationScreenRouteName);
                      }
                    },
                    borderColor: ColorManager.lightprimary,
                    color: ColorManager.lightprimary,
                    bottonWidget: Text(AppLocalizations.of(context)!.register,
                    style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                                color: ColorManager.white, fontSize: 16.sp)
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
                      //  todo: Navigate to login screen
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          SignInScreen.signInScreenRouteName,
                          (route) => false,
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
    );
  }
}