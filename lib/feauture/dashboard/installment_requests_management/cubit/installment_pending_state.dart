import '../../../../domain/entities/installment_pending_entity.dart';

abstract class InstallmentPendingState {}

class InstallmentPendingInitial extends InstallmentPendingState {}

class InstallmentPendingLoading extends InstallmentPendingState {}

class InstallmentPendingLoaded extends InstallmentPendingState {
  final List<InstallmentPendingEntity> requests;

  InstallmentPendingLoaded(this.requests);
}

class InstallmentPendingError extends InstallmentPendingState {
  final String message;

  InstallmentPendingError(this.message);
}

// ------------------- Update States -------------------

class InstallmentPendingUpdating extends InstallmentPendingState {}

class InstallmentPendingUpdated extends InstallmentPendingState {
  final String message;

  InstallmentPendingUpdated(this.message);
}

class InstallmentPendingUpdateError extends InstallmentPendingState {
  final String message;

  InstallmentPendingUpdateError(this.message);
}
