import 'dart:async';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../api_service/di/di.dart';
import '../../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../forget_password/controller/forget_passwors_cubit.dart';
import '../../forget_password/controller/forget_passwors_states.dart';
import '../../set_new_password/reset_password.dart';

class OtpVerficationScreen extends StatefulWidget {
  const OtpVerficationScreen({super.key});
  static String otpVerficationScreenRouteName = "otpVerficationScreen";

  @override
  State<OtpVerficationScreen> createState() => _OtpVerficationScreenState();
}

class _OtpVerficationScreenState extends State<OtpVerficationScreen> {
  ForgetPassworsCubit forgetPassworsCubit = getIt<ForgetPassworsCubit>();

  final List<TextEditingController> _codeControllers =
  List.generate(6, (_) => TextEditingController());
  Timer? _timer;
  int _seconds = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onConfirm() {
    String code = _codeControllers.map((c) => c.text).join();
    // TODO: Handle code confirmation logic
    Navigator.of(context).pushNamed(ResetPasswordScreen.resetPasswordScreenRouteName);
  }

  void _onResend(email)async {

    // TODO: Implement resend logic
    _startTimer();


  }
  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2 || parts[0].length < 2) return email;
    final first = parts[0][0];
    final masked = '*' * (parts[0].length - 1);
    return '$first$masked@${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    final String? email = ModalRoute.of(context)!.settings.arguments as String?;

    return
      BlocListener<ForgetPassworsCubit, ForgetPasswordState>(
        bloc: forgetPassworsCubit,
        listener: (context, state) {
      if (state is ForgetPasswordLoading) {
        CustomDialog.loading(
            context: context,
            message: "loading",
            cancelable: false);
      } else if (state is ForgetPasswordFailure) {
        Navigator.of(context).pop();
        CustomDialog.positiveButton(
            context: context,
            title: "error",
            message: state.errorMessage);
      } else if (state is ForgetPasswordSuccess) {
        Navigator.of(context).pop();
        CustomDialog.positiveButton(
            context: context,
            title: "getTranslations(context).success",
            message: state.message,
            positiveOnClick: () =>Navigator.of(context).pop()

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
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Image.asset(
                  ImageAssets.appIcon,
                  height: 200.h,
                ),
                backgroundColor: Colors.black,
                radius: 35.r,
              ),
              SizedBox(height: 30.h),
              Text(
                AppLocalizations.of(context)!.verifyOtp,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Text(
                AppLocalizations.of(context)!.verifyEmailSubTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
                textAlign: TextAlign.center,
              ),
              Text(
                email != null ? maskEmail(email) : "",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40.h),
              Text(AppLocalizations.of(context)!.codeWasSentTo,style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 12.sp, color: ColorManager.darkGrey),),
              SizedBox(height: 10.h),
              _canResend
                  ?
              TextButton(
                onPressed:(){
                  if (email != null) {
                    forgetPassworsCubit.emailController.text = email!;
                    forgetPassworsCubit.forgetPassword();
                  }
                },

                child: Text(
                  AppLocalizations.of(context)!.resendCode,
                  style: TextStyle(
                    color: ColorManager.lightgreen,
                    fontSize: 16.sp,
                  ),
                ),
              )

                  : Text(
                "${AppLocalizations.of(context)!.resendCode} ${AppLocalizations.of(context)!.n} $_seconds s",
                style: TextStyle(
                  color: ColorManager.lightgreen,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 40.h),
              CustomizedElevatedButton(
                onPressed: _onConfirm,
                borderColor: ColorManager.lightprimary,
                color: ColorManager.lightprimary,
                bottonWidget: Text(
                  AppLocalizations.of(context)!.confirm,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: ColorManager.white, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}