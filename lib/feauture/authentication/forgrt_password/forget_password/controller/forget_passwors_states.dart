
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  String? message;

  ForgetPasswordSuccess({this.message});
}

class ForgetPasswordFailure extends ForgetPasswordState {
  String errorMessage;

  ForgetPasswordFailure({required this.errorMessage});
}
