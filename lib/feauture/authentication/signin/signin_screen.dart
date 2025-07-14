import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/authentication/signin/controller/sigin_cubit.dart';
import 'package:ankh_project/feauture/authentication/signin/controller/sigin_states.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api_service/di/di.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../core/validator/my_validator.dart';
import '../../home_screen/bottom_nav_bar.dart';
import '../email_verfication/email_verfication_screen.dart';
import '../forgrt_password/forget_password/forget_password_screen.dart';
import '../register/register _screen.dart';

  class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static String signInScreenRouteName = "SignInScreen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SignInCubit signInViewModel = getIt<SignInCubit>();


  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
        bloc: signInViewModel,
        listener: (context, state) {
      if (state is SignInLoading) {
        CustomDialog.loading(
            context: context,
            message: "loading",
            cancelable: false);
      } else if (state is SignInFailure) {
        Navigator.of(context).pop();
        CustomDialog.positiveButton(
            context: context,
            //title: "error",
            message: state.error.errorMessage);
      } else if (state is SignInSuccess) {
        print("ttttttttttttttttt${state.response?.user?.deviceTokens}");
        print("message: ${state.response.message}");
        print("token: ${state.response.token}");
        print("user: ${state.response.user}");
        Navigator.of(context).pop();
        CustomDialog.positiveButton(
            context: context,
            //title: "getTranslations(context).success",
            message: state.response.message,
            positiveOnClick: () =>
                Navigator.of(context).pushNamed(
                    ClientBottomNavBar.bottomNavBarRouteName
                    ));
      }
    },



    child:Scaffold(
      appBar: AppBar(),
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
                  AppLocalizations.of(context)!.signIn,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.signInSubTitle,
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
                  controller: signInViewModel.email,
                  hintText: AppLocalizations.of(context)!.enterYourEmail,
                  keyboardType: TextInputType.multiline,
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
                  controller: signInViewModel.password,
                  hintText: AppLocalizations.of(context)!.enterYourPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: !_isPasswordVisible,
                  validator: (value) => ValidatorUtils.validatePassword(value, context),
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
                SizedBox(height: 10.h),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ForgetPasswordScreen.forgetPasswordScreenRouteName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
                    ),
                  ),
                ],),
                SizedBox(height: 40.h),
                CustomizedElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signInViewModel.signIn();
                    }
                  },
                  borderColor: ColorManager.lightprimary,
                  color: ColorManager.lightprimary,
                  bottonWidget: Text(AppLocalizations.of(context)!.log,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          color: ColorManager.white, fontSize: 16.sp)
                  ),

                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dontHaveAccount,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 14.sp, color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RegisterScreen.registerScreenRouteName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.registerNow,
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
    )
    );
  }
}