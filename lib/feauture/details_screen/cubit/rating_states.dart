import 'package:ankh_project/api_service/failure/error_handling.dart';

abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {
  final String message;

  RatingSuccess({required this.message});
}

class RatingError extends RatingState {
  final Failure error;

  RatingError({required this.error});
}