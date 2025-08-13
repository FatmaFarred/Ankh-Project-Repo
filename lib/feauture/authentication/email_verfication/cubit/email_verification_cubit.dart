import 'dart:async';
import 'package:ankh_project/feauture/authentication/email_verfication/cubit/email_verification_states.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/di/di.dart';
import '../../../../api_service/failure/error_handling.dart';
import '../../../../domain/use_cases/authentication/email_verfication.dart';
import '../../../../domain/use_cases/authentication/resent_email_verfication.dart';

@injectable
class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final EmailVerificationUseCase emailVerificationUseCase;
  final ResentEmailVerficationUseCase resendEmailVerificationUseCase;

  Timer? _timer;
  int _seconds = 60;
  bool _canResend = false;
  String _email = '';

  EmailVerificationCubit(
    this.emailVerificationUseCase,
    this.resendEmailVerificationUseCase,
  ) : super(EmailVerificationInitial()) {
    print("🔍 EmailVerificationCubit created successfully");
  }

  // Getters
  int get seconds => _seconds;
  bool get canResend => _canResend;

  // Set email for verification
  void setEmail(String email) {
    print("🔍 Setting email in cubit: $email");
    _email = email;
  }

  // Start timer for resend functionality
  void startTimer() {
    _seconds = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _canResend = true;
        emit(EmailVerificationInitial());
        timer.cancel();
      } else {
        _seconds--;
        emit(EmailVerificationInitial());
      }
    });
  }

  // Verify email with code
  Future<void> verifyEmail(String code) async {
    print("🔍 [CUBIT] verifyEmail called with code: $code, email: '$_email'");
    print("🔍 [CUBIT] Email is empty: ${_email.isEmpty}");
    
    if (_email.isEmpty) {
      print("❌ [CUBIT] Email is empty, emitting failure");
      emit(EmailVerificationFailure(
        error: Failure(errorMessage: 'Email is required'),
      ));
      return;
    }

    emit(EmailVerificationLoading());
    print("🚀 Starting email verification...");

    var either = await emailVerificationUseCase.execute(_email, code);
    either.fold((error) {
      print("❌ Email Verification Error: ${error.errorMessage}");
      emit(EmailVerificationFailure(error: error));
    }, (response) {
      print("✅ Email Verification Success: ${response}");
      emit(EmailVerificationSuccess(message: response));
    });
  }

  // Resend email verification
  Future<void> resendEmailVerification() async {
    if (_email.isEmpty) {
      emit(ResendEmailVerificationFailure(
        error: Failure(errorMessage: 'Email is required'),
      ));
      return;
    }

    if (!_canResend) {
      return;
    }

    emit(ResendEmailVerificationLoading());
    print("🚀 Starting resend email verification...");

    var either = await resendEmailVerificationUseCase.execute(_email);
    either.fold((error) {
      print("❌ Resend Email Verification Error: ${error.errorMessage}");
      emit(ResendEmailVerificationFailure(error: error));
    }, (response) {
      print("✅ Resend Email Verification Success: ${response}");
      startTimer(); // Restart timer after successful resend
      emit(ResendEmailVerificationSuccess(message: response));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
