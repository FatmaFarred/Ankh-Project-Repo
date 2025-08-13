import 'package:ankh_project/feauture/authentication/register/controller/register_states.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as dio;
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../../domain/use_cases/authentication/client_register_use_case.dart';
import '../../../../domain/use_cases/authentication/register_usecase.dart';
import '../../../../domain/use_cases/authentication/team_member_register.dart';
import '../../../../domain/entities/authentication_response_entity.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;
  final ClientRegisterUseCase clientRegisterUseCase;
  final TeamMemberRegister teamMemberRegisterUseCase;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController invitationCodeController = TextEditingController();

  bool isPasswordVisible = false;

  RegisterCubit(this.registerUseCase, this.clientRegisterUseCase, this.teamMemberRegisterUseCase) : super(RegisterInitial());

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

  Future<void> clientRegister() async {
    emit(RegisterLoading());

    var either = await clientRegisterUseCase.execute(
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

  Future<void> teamMemberRegister() async {
    emit(RegisterLoading());

    var either = await teamMemberRegisterUseCase.execute(
      fullNameController.text,
      emailController.text,
      passwordController.text,
      phoneController.text,
      invitationCodeController.text,
    );
    either.fold((error) {
      emit(RegisterFailure(error: error));
    }, (response) {
      // Create a mock AuthenticationResponseEntity for consistency
      final mockResponse = AuthenticationResponseEntity(
        message: response ?? "Team member registered successfully",
        token: null,
        user: null,
      );
      emit(RegisterSuccess(response: mockResponse));
    });
  }
}
