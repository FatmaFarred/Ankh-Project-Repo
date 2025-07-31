


import '../../../domain/entities/user_profile_entity.dart';
import '../../../api_service/failure/error_handling.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileEntity profile;

  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final Failure error;

  ProfileError(this.error);
}
