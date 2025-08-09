import '../../../api_service/failure/error_handling.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;
  EditProfileSuccess(this.message);
}

class EditProfileError extends EditProfileState {
  final Failure error;
  EditProfileError(this.error);
} 