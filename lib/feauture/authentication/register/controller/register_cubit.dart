import 'package:ankh_project/feauture/authentication/register/controller/register_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../../domain/use_cases/authentication/register_usecase.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  final email = TextEditingController(text: "fatma267@gmail.com");
  final userName = TextEditingController(text: "fatma");
  final password = TextEditingController(text: "fatma1234");
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterInitial());
  }

  Future<void> register() async {

    emit(RegisterLoading());

    try {
      final user = await registerUseCase.execute(
        email.text.trim(),
        password.text.trim(),
        userName.text.trim(),

      );

      if (user != null) {
        emit(RegisterSuccess());

      }
    }  catch (e) {
      emit(RegisterFailure(AuthFailure(e.toString())));

    }
  }
}
