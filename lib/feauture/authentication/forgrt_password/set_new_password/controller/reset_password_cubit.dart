
import 'package:ankh_project/feauture/authentication/forgrt_password/set_new_password/controller/reset_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../api_service/failure/error_handling.dart';
import '../../../../../domain/use_cases/authentication/reset_password_use_case.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  ResetPasswordCubit(this.resetPasswordUseCase) : super(ResetPasswordInitial());

  Future<void> resetPassword(String email, String token, String password) async {
    emit(ResetPasswordLoading());

    try {
      final either = await resetPasswordUseCase.execute(email, password, token);

      either.fold(
        (failure) {
          emit(ResetPasswordFailure(errorMessage: failure?.errorMessage??""));
        },
        (response) {
          if (response != null && response.isNotEmpty) {
            emit(ResetPasswordSuccess(message: response));
          } else {
            emit(ResetPasswordFailure(errorMessage: 'No response received'));
          }
        },
      );
    } catch (e) {
      emit(ResetPasswordFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}