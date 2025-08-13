import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/all_point_price_entity.dart';

abstract class CommissionRateStates extends Equatable {
  const CommissionRateStates();

  @override
  List<Object?> get props => [];
}



class CommissionRateInitial extends CommissionRateStates {
  const CommissionRateInitial();
}
class CommissionRateLoading extends CommissionRateStates {
  const CommissionRateLoading();
}

class CommissionRateSuccess extends CommissionRateStates {
  final String? response;

  const CommissionRateSuccess({this.response});

  @override
  List<Object?> get props => [response];
}

class CommissionRateError extends CommissionRateStates {
  final Failure error;

  const CommissionRateError({required this.error});

  @override
  List<Object?> get props => [error];
} 