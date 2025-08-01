import 'package:ankh_project/api_service/failure/error_handling.dart';

import '../../../../domain/entities/authentication_response_entity.dart';
import '../../../../domain/entities/register_response_entity.dart';

abstract class FavoriteToggleState {}

class FavoriteInitial extends FavoriteToggleState {}

class FavoriteLoading extends FavoriteToggleState {}

class FavoriteSuccess extends FavoriteToggleState {
  String response;
  FavoriteSuccess({required this.response});

}

class FavoriteFailure extends FavoriteToggleState {
  Failure error;

  FavoriteFailure({required this.error});
}