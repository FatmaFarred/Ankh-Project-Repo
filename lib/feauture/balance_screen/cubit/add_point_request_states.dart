import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';

abstract class AddPointRequestState extends Equatable {
  const AddPointRequestState();

  @override
  List<Object?> get props => [];
}

class AddPointRequestInitial extends AddPointRequestState {
  const AddPointRequestInitial();
}

class AddPointRequestLoading extends AddPointRequestState {
  const AddPointRequestLoading();
}

class AddPointRequestSuccess extends AddPointRequestState {
  final String? message;

  const AddPointRequestSuccess({this.message});

  @override
  List<Object?> get props => [message];
}

class AddPointRequestError extends AddPointRequestState {
  final Failure error;

  const AddPointRequestError({required this.error});

  @override
  List<Object?> get props => [error];
} 