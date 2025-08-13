
import 'package:ankh_project/feauture/authentication/signin/controller/sigin_states.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/di/di.dart';
import '../../../../domain/use_cases/authentication/signin_usecase.dart';
import '../../../profile/cubit/profile_cubit.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;

  final email = TextEditingController();
  final password = TextEditingController();
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
      final String token = response.token??"";
      final String userId = response.user?.id??"";
      final profileCubit = getIt<ProfileCubit>();
      profileCubit.fetchProfile(token, userId); // No await — runs in background



      emit(SignInSuccess(response:response));
    });
  }
}
