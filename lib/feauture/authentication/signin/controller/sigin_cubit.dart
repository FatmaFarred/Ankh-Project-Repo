import 'package:ankh_project/domain/entities/register_response_entity.dart';
import 'package:ankh_project/feauture/authentication/register/controller/register_states.dart';
import 'package:ankh_project/feauture/authentication/signin/controller/sigin_states.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/entities/login_response_entity.dart';
import '../../../../domain/use_cases/authentication/register_usecase.dart';
import '../../../../domain/use_cases/authentication/signin_usecase.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;

  final email = TextEditingController(text: "mohamed@gmail.com");
  final password = TextEditingController(text: "fatma1234");
  bool isPasswordVisible = false;

  SignInCubit(this.signInUseCase) : super(SignInInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignInInitial());
  }

  Future<void> signIn() async {
    emit(SignInLoading());

    var either = await signInUseCase.execute(
      email.text,
      password.text,
    );
    either.fold((error) {
      emit(SignInFailure(error: error));
    }, (response) {
      emit(SignInSuccess(response: response));
    });
  }
}
