part of 'push_notification_cubit.dart';

abstract class PushNotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PushNotificationInitial extends PushNotificationState {}

class PushNotificationLoading extends PushNotificationState {}

class PushNotificationSuccess extends PushNotificationState {
  String? message;
  PushNotificationSuccess({ this.message});
}

class PushNotificationFailure extends PushNotificationState {
  final Failure? error;
  String? errorMessage;


  PushNotificationFailure({ this.error,this.errorMessage});
  
  @override
  List<Object?> get props => [error];
} 