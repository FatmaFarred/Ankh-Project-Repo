import 'dart:async';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerficationScreen extends StatefulWidget {
  const EmailVerficationScreen({super.key});
  static String emailVerficationScreenRouteName = "EmailVerficationScreen";

  @override
  State<EmailVerficationScreen> createState() => _EmailVerficationScreenState();
}

class _EmailVerficationScreenState extends State<EmailVerficationScreen> {
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
  }

  void _onResend() {
    // TODO: Implement resend logic
    _startTimer();
  }

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
                AppLocalizations.of(context)!.verifyEmailTitle,
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
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 40.w,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    child: TextField(
                      controller: _codeControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              SizedBox(height: 10.h),
              Text(AppLocalizations.of(context)!.codeWasSentTo,style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 12.sp, color: ColorManager.darkGrey),),
              SizedBox(height: 24.h),
              _canResend
                  ?
                      TextButton(
                                      onPressed: _onResend,
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
    );
  }
}