
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_cases/forget_reset_password_usecse/forget_password_usecase.dart';
import 'forget_passwors_states.dart';

@injectable
class ForgetPassworsCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  final TextEditingController emailController = TextEditingController();


  ForgetPassworsCubit(this.forgetPasswordUseCase) : super(ForgetPasswordInitial());




  Future<void> forgetPassword() async {
    emit(ForgetPasswordLoading());

    try {
      final response = await forgetPasswordUseCase.execute(emailController.text);

      if (response != null && response.isNotEmpty) {
        emit(ForgetPasswordSuccess(message: response??""));
      } else {
        emit(ForgetPasswordFailure(errorMessage: 'No response received'));
      }
    } catch (e) {
      emit(ForgetPasswordFailure(errorMessage: e.toString()));
    }
  }
}