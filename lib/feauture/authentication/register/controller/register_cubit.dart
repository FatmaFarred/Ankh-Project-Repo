import 'package:ankh_project/feauture/authentication/register/controller/register_states.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as dio;
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../../domain/use_cases/authentication/register_usecase.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterInitial());
  }

  Future<void> register() async {

    emit(RegisterLoading());

    var either = await registerUseCase.execute(
        fullNameController.text,
        emailController.text,
        passwordController.text,
        phoneController.text,
      );
    either.fold((error) {
      emit(RegisterFailure(error: error));
    }, (response) {
      emit(RegisterSuccess(response: response));
    });
  }
}
