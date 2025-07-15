
import 'package:ankh_project/feauture/authentication/signin/controller/sigin_states.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/authentication/signin_usecase.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;

  final email = TextEditingController(text: "fahmyroma690@gmail.com");
  final password = TextEditingController(text: "Fahmy690@@");
  bool isPasswordVisible = false;

  SignInCubit(this.signInUseCase) : super(SignInInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignInInitial());
  }

  Future<void> signIn() async {
    emit(SignInLoading());
    print("🚀 Starting signIn...");


    var either = await signInUseCase.execute(
      email.text,
      password.text,
    );
    either.fold((error) {
      print("❌ SignIn Error: ${error.errorMessage}");

      emit(SignInFailure(error: error));
    }, (response) {
      print("✅ SignIn Success: ${response.message}");

      emit(SignInSuccess(response:response));
    });
  }
}
