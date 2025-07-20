import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_service/di/di.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../core/validator/my_validator.dart';
import '../../welcome_screen/welcome_screen.dart';
import '../email_verfication/email_verfication_screen.dart';
import '../signin/signin_screen.dart';
import 'controller/register_cubit.dart';
import 'controller/register_states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String registerScreenRouteName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterCubit registerViewModel = getIt<RegisterCubit>();


  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {

    return BlocListener<RegisterCubit, RegisterState>(
        bloc: registerViewModel,
        listener: (context, state) {
      if (state is RegisterLoading) {
        CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false);
      } else if (state is RegisterFailure) {
        Navigator.of(context).pop();
        CustomDialog.positiveAndNegativeButton(
            context: context,
            positiveText:  AppLocalizations.of(context)!.tryAgain,
            positiveOnClick: () {
              Navigator.of(context).pop();
              registerViewModel.register();

            },
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage);
      } else if (state is RegisterSuccess) {
        Navigator.of(context).pop();
        CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.response.message,
            positiveOnClick: () =>
                Navigator.of(context).pushNamed(
                    EmailVerficationScreen.emailVerficationScreenRouteName));
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
                    controller: registerViewModel.fullNameController,
                    hintText: AppLocalizations.of(context)!.enterYourName,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) => ValidatorUtils.validateName(value, context),

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
                    controller: registerViewModel.phoneController,
                    hintText: AppLocalizations.of(context)!.enterYourPhone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) => ValidatorUtils.validatePhone(value, context),
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
                    controller: registerViewModel.emailController,
                    hintText: AppLocalizations.of(context)!.enterYourName,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) => ValidatorUtils.validateEmail(value, context),
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
                    controller: registerViewModel.passwordController,
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
                        registerViewModel.register();


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