import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/balance_response_entity.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object?> get props => [];
}

class BalanceInitial extends BalanceState {
  const BalanceInitial();
}

class BalanceLoading extends BalanceState {
  const BalanceLoading();
}

class BalanceSuccess extends BalanceState {
  final BalanceResponseEntity balance;

  const BalanceSuccess({required this.balance});

  @override
  List<Object?> get props => [balance];
}

class BalanceEmpty extends BalanceState {
  final String? message;

  const BalanceEmpty({this.message});

  @override
  List<Object?> get props => [message];
}

class BalanceError extends BalanceState {
  final Failure error;

  const BalanceError({required this.error});

  @override
  List<Object?> get props => [error];
} 