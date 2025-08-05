part of 'get_notification_cubit.dart';

abstract class GetNotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNotificationInitial extends GetNotificationState {}

class GetNotificationLoading extends GetNotificationState {}

class GetNotificationSuccess extends GetNotificationState {
  final List<NotificationEntity> notifications;

  GetNotificationSuccess({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class GetNotificationEmpty extends GetNotificationState {}

class GetNotificationFailure extends GetNotificationState {
  final Failure? error;
  final String? errorMessage;

  GetNotificationFailure({this.error, this.errorMessage});

  @override
  List<Object?> get props => [error, errorMessage];
} 