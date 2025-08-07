import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/edit_profile_use_case.dart';
import 'edit_profile_states.dart';

@singleton
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase editProfileUseCase;

  EditProfileCubit(this.editProfileUseCase) : super(EditProfileInitial());

  Future<void> editProfile({
    required String token,
    required String userId,
    required String fullName,
    required String email,
    required String phone,
     File? image,
  }) async {
    emit(EditProfileLoading());

    final result = await editProfileUseCase.execute(
      token,
      userId,
      fullName,
      email,
      phone,
      image,
    );

    result.fold(
      (error) => emit(EditProfileError(error)),
      (message) => emit(EditProfileSuccess(message ?? 'Profile updated successfully')),
    );
  }
} 