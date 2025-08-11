import 'dart:async';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../api_service/di/di.dart';
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
  ForgetPasswordCubit forgetPassworsCubit = getIt<ForgetPasswordCubit>();

  final List<TextEditingController> _codeControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

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
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onConfirm() {
    String code = _codeControllers.map((c) => c.text).join();

    if (code.length == 6) {
      // Get the email from the route arguments
      final String? email = ModalRoute.of(context)!.settings.arguments as String?;

      if (email != null) {
        // Navigate to reset password screen with email and code
        Navigator.of(context).pushNamed(
          ResetPasswordScreen.resetPasswordScreenRouteName,
          arguments: {
            'email': email,
            'token': code,
          },
        );
      } else {
        // Show error if email is not available
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not found. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Show error if code is incomplete
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete 6-digit code.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _onResend() async {
    final String? email = ModalRoute.of(context)!.settings.arguments as String?;
    if (email != null) {
      forgetPassworsCubit.emailController.text = email;
      forgetPassworsCubit.forgetPassword();
    }
    _startTimer();
  }

  void _handleCodeInput(String value, int index) {
    if (value.isNotEmpty) {
      // If pasting a 6-digit code
      if (value.length == 6 && value.contains(RegExp(r'^[0-9]{6}$'))) {
        _distributeCode(value);
        return;
      }

      // Single digit input - always fill from left to right
      if (value.length == 1) {
        // Find the next empty field to the right
        int nextEmptyIndex = index + 1;
        while (nextEmptyIndex < 6 && _codeControllers[nextEmptyIndex].text.isNotEmpty) {
          nextEmptyIndex++;
        }

        if (nextEmptyIndex < 6) {
          // Move focus to the next empty field
          _focusNodes[nextEmptyIndex].requestFocus();
        }
      }
    } else if (value.isEmpty && index > 0) {
      // Handle backspace - move to previous field
      FocusScope.of(context).previousFocus();
    }
  }

  void _distributeCode(String code) {
    // Clear all controllers first
    for (int i = 0; i < 6; i++) {
      _codeControllers[i].text = '';
    }

    // Distribute the code across all fields from LEFT to RIGHT
    for (int i = 0; i < 6 && i < code.length; i++) {
      _codeControllers[i].text = code[i];
    }

    // Move focus to the first empty field after the last filled one
    int lastFilledIndex = code.length - 1;
    if (lastFilledIndex < 5) {
      _focusNodes[lastFilledIndex + 1].requestFocus();
    } else {
      _focusNodes[5].requestFocus();
    }
  }

  void _clearAllFields() {
    for (int i = 0; i < 6; i++) {
      _codeControllers[i].clear();
    }
    // Focus on first field
    _focusNodes[0].requestFocus();
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

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      bloc: forgetPassworsCubit,
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is ForgetPasswordFailure) {
          Navigator.of(context).pop();
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: state.errorMessage ?? 'An error occurred',
          );
        } else if (state is ForgetPasswordSuccess) {
          Navigator.of(context).pop();
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.message ?? 'Code resent successfully!',
            positiveOnClick: () => Navigator.of(context).pop(),
          );
        }
      },
      child: Scaffold(
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
                if (email != null) ...[
                  SizedBox(height: 10.h),
                  Text(
                    maskEmail(email),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 14.sp, color: ColorManager.darkGrey),
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: 40.h),
                // 6 Input Fields for OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 40.w,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      child: TextField(
                        controller: _codeControllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        cursorWidth: 2.0,
                        cursorHeight: 20.h,
                        maxLength: 6, // Allow pasting full code
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          hintText: '',
                          contentPadding: EdgeInsets.only(left: 8.w, right: 8.w),
                        ),
                        onChanged: (value) => _handleCodeInput(value, index),
                        onTap: () {
                          // Clear all fields when tapping on any field
                          _clearAllFields();
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.codeWasSentTo,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 12.sp, color: ColorManager.darkGrey),
                ),
                SizedBox(height: 24.h),
                _canResend
                    ? TextButton(
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
      ),
    );
  }
}