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

  /// Force refresh profile data after updates
  Future<void> refreshProfile() async {
    // This method can be called to force a refresh
    // It will re-emit the current state to trigger UI updates
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(ProfileLoaded(currentState.profile));
    }
  }

  /// Preload profile data on app startup
  Future<void> preloadProfileData() async {
    // This method can be called during app initialization
    // to start loading profile data early
    if (state is ProfileInitial) {
      // Emit loading state to show loading UI immediately
      emit(ProfileLoading());
    }
  }
}
