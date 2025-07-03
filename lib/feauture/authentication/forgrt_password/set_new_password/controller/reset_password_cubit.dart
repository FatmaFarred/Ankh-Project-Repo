
import 'package:ankh_project/feauture/authentication/forgrt_password/set_new_password/controller/reset_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_cases/forget_reset_password_usecse/forget_password_usecase.dart';
import '../../../../../domain/use_cases/forget_reset_password_usecse/reset_password_use_case.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();



  ResetPasswordCubit(this.resetPasswordUseCase) : super(ResetPasswordInitial());




  Future<void> resetPassword(String email, String token) async {
    emit(ResetPasswordLoading());

    try {
      final response = await resetPasswordUseCase.execute(passwordController.text,token,email);

      if (response != null && response.isNotEmpty) {
        emit(ResetPasswordSuccess(message: response??""));
      } else {
        emit(ResetPasswordFailure(errorMessage: 'No response received'));
      }
    } catch (e) {
      emit(ResetPasswordFailure(errorMessage: e.toString()));
    }
  }
}