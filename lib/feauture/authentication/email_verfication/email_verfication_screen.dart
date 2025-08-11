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
import 'package:ankh_project/feauture/authentication/email_verfication/cubit/email_verification_cubit.dart';
import 'package:ankh_project/feauture/authentication/email_verfication/cubit/email_verification_states.dart';
import 'package:ankh_project/feauture/authentication/signin/signin_screen.dart';
import '../../../api_service/di/di.dart';

class EmailVerficationScreen extends StatefulWidget {
  const EmailVerficationScreen({super.key, this.email});
  static String emailVerficationScreenRouteName = "EmailVerficationScreen";

  final String? email;

  @override
  State<EmailVerficationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerficationScreen> {
  final List<TextEditingController> _codeControllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  late final EmailVerificationCubit _emailVerificationCubit;

  @override
  void initState() {
    super.initState();

    try {
      // Get the cubit instance once and reuse it
      _emailVerificationCubit = getIt<EmailVerificationCubit>();

      // Set email in cubit if provided
      if (widget.email != null) {
        _emailVerificationCubit.setEmail(widget.email!);
      }
      // Start timer
      _emailVerificationCubit.startTimer();
    } catch (e) {
      print("❌ Error initializing EmailVerificationScreen: $e");
    }
  }

  @override
  void dispose() {
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
      try {
        _emailVerificationCubit.verifyEmail(code);
      } catch (e) {
        print("❌ Error calling verifyEmail: $e");
      }
    }
  }

  void _onResend() {
    _emailVerificationCubit.resendEmailVerification();
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

  @override
  Widget build(BuildContext context) {

    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      bloc: _emailVerificationCubit,
      listener: (context, state) {
        if (state is EmailVerificationLoading) {
          // Show loading dialog
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is EmailVerificationSuccess) {
          // Close loading dialog first
          Navigator.of(context).pop();
          
          // Show success dialog and navigate to sign-in screen
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.message ?? 'Email verified successfully!',
            positiveOnClick: () {
              Navigator.of(context).pushReplacementNamed(
                SignInScreen.signInScreenRouteName,
              );
            },
          );
        } else if (state is EmailVerificationFailure) {
          // Close loading dialog first
          Navigator.of(context).pop();
          
          // Show error dialog
          CustomDialog.positiveButton(
            context: context,
            title: 'Verification Failed',
            message: state.error.errorMessage ?? 'Verification failed',
          );
        } else if (state is ResendEmailVerificationLoading) {
          // Show loading dialog for resend
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is ResendEmailVerificationSuccess) {
          // Close loading dialog first
          Navigator.of(context).pop();
          
          // Show success dialog for resend
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.message ?? 'Verification code resent successfully!',
          );
        } else if (state is ResendEmailVerificationFailure) {
          // Close loading dialog first
          Navigator.of(context).pop();
          
          // Show error dialog for resend
          CustomDialog.positiveButton(
            context: context,
            title: 'Failed to Resend',
            message: state.error.errorMessage ?? 'Failed to resend code',
          );
        }
      },
      child: BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
        bloc: _emailVerificationCubit,
        builder: (context, state) {
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
                    BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
                      bloc: _emailVerificationCubit,
                      buildWhen: (previous, current) =>
                        current is ResendEmailVerificationLoading ||
                        current is ResendEmailVerificationSuccess ||
                        current is ResendEmailVerificationFailure ||
                        _emailVerificationCubit.canResend != (previous is ResendEmailVerificationLoading ||
                                                           previous is ResendEmailVerificationSuccess ||
                                                           previous is ResendEmailVerificationFailure ||
                                                           _emailVerificationCubit.canResend),
                      builder: (context, state) {
                        return _emailVerificationCubit.canResend
                            ? TextButton(
                                onPressed: state is ResendEmailVerificationLoading ? null : _onResend,
                                child: state is ResendEmailVerificationLoading
                                    ? SizedBox(
                                        width: 16.w,
                                        height: 16.h,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            ColorManager.lightgreen,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!.resendCode,
                                        style: TextStyle(
                                          color: ColorManager.lightgreen,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                              )
                                                            : Text(
                                "${AppLocalizations.of(context)!.resendCodeIn}${_emailVerificationCubit.seconds} s",
                                style: TextStyle(
                                  color: ColorManager.lightgreen,
                                  fontSize: 16.sp,
                                ),
                              );
                      },
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
                      bloc: _emailVerificationCubit,
                      buildWhen: (previous, current) =>
                        current is EmailVerificationLoading ||
                        current is EmailVerificationSuccess ||
                        current is EmailVerificationFailure,
                      builder: (context, state) {
                        final isButtonEnabled = !(state is EmailVerificationLoading);
                        
                        return GestureDetector(
                          onTap: isButtonEnabled ? _onConfirm : null,
                          child: CustomizedElevatedButton(
                            onPressed: isButtonEnabled ? _onConfirm : null,
                            borderColor: ColorManager.lightprimary,
                            color: ColorManager.lightprimary,
                            bottonWidget: state is EmailVerificationLoading
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorManager.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.confirm,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: ColorManager.white, fontSize: 16.sp),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}