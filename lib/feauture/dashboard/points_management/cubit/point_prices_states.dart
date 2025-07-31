import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/all_point_price_entity.dart';

abstract class PointPricesState extends Equatable {
  const PointPricesState();

  @override
  List<Object?> get props => [];
}

class PointPricesInitial extends PointPricesState {
  const PointPricesInitial();
}

class PointPricesLoading extends PointPricesState {
  const PointPricesLoading();
}

class PointPricesSuccess extends PointPricesState {
  final List<AllPointPriceEntity> pointPrices;

  const PointPricesSuccess({required this.pointPrices});

  @override
  List<Object?> get props => [pointPrices];
}

class PointPricesEmpty extends PointPricesState {
  final String? message;

  const PointPricesEmpty({this.message});

  @override
  List<Object?> get props => [message];
}

class PointPricesError extends PointPricesState {
  final Failure error;

  const PointPricesError({required this.error});

  @override
  List<Object?> get props => [error];
}

// States for edit price actions
class EditPriceLoading extends PointPricesState {
  const EditPriceLoading();
}

class EditPriceSuccess extends PointPricesState {
  final String? response;

  const EditPriceSuccess({this.response});

  @override
  List<Object?> get props => [response];
}

class EditPriceError extends PointPricesState {
  final Failure error;

  const EditPriceError({required this.error});

  @override
  List<Object?> get props => [error];
} 