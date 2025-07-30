// profile_cubit.dart

import 'package:ankh_project/feauture/profile/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/get_profile_use_case.dart';

@singleton
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(this.getProfileUseCase) : super(ProfileInitial());

  Future<void> fetchProfile(String token, String userId) async {
    emit(ProfileLoading());

    var  result =
    await getProfileUseCase.execute(token, userId);

    result.fold(
          (error) => emit(ProfileError(error)),
          (profile) => emit(ProfileLoaded(profile)),
    );
  }
}
