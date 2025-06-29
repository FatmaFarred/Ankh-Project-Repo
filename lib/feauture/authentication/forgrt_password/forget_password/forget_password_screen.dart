import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets_manager.dart';
import '../../../../core/validator/my_validator.dart';
import '../../email_verfication/email_verfication_screen.dart';
import '../../signin/signin_screen.dart';
import '../verify_otp/verify_otp_screen/verify_otp_screen.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static String forgetPasswordScreenRouteName = "ForgetPasswordScreen";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();


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
                  AppLocalizations.of(context)!.forgotPasswordTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.forgetPasswordSubTitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
                ),
                SizedBox(height: 55.h),

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


                SizedBox(height: 40.h),
                CustomizedElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle registration logic here
                      Navigator.of(context).pushNamed(OtpVerficationScreen.otpVerficationScreenRouteName);
                    }
                  },
                  borderColor: ColorManager.lightprimary,
                  color: ColorManager.lightprimary,
                  bottonWidget: Text(AppLocalizations.of(context)!.confirm,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          color: ColorManager.white, fontSize: 16.sp)
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}