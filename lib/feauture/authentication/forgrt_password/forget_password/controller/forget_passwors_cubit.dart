
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../../api_service/failure/error_handling.dart';
import '../../../../../domain/use_cases/authentication/foget_password_use_case.dart';
import 'forget_passwors_states.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  final TextEditingController emailController = TextEditingController();

  ForgetPasswordCubit(this.forgetPasswordUseCase) : super(ForgetPasswordInitial());

  Future<void> forgetPassword() async {
    emit(ForgetPasswordLoading());

    try {
      final either = await forgetPasswordUseCase.execute(emailController.text);

      either.fold(
        (failure) {
          emit(ForgetPasswordFailure(errorMessage: failure.errorMessage ?? 'An error occurred'));
        },
        (response) {
          if (response != null && response.isNotEmpty) {
            emit(ForgetPasswordSuccess(message: response));
          } else {
            emit(ForgetPasswordFailure(errorMessage: 'No response received'));
          }
        },
      );
    } catch (e) {
      emit(ForgetPasswordFailure(errorMessage: e.toString()));
    }
  }


  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}