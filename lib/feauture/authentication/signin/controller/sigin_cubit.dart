import 'package:ankh_project/feauture/authentication/register/controller/register_states.dart';
import 'package:ankh_project/feauture/authentication/signin/controller/sigin_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/use_cases/authentication/register_usecase.dart';
import '../../../../domain/use_cases/authentication/signin_usecase.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;

  final email = TextEditingController(text: "fatma267@gmail.com");
  final userName = TextEditingController(text: "fatma");
  final password = TextEditingController(text: "fatma1234");
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  SignInCubit(this.signInUseCase) : super(SignInInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignInInitial());
  }

  Future<MyUser?> signIn() async {

    emit(SignInLoading());

    try {
      final user = await signInUseCase.execute(
        email.text.trim(),
        password.text.trim(),


      );

      if (user != null) {
        emit(SignInSuccess());
        return user;

      }
    }  catch (e) {
      emit(SignInFailure(AuthFailure(e.toString())));

    }
  }
}
