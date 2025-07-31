import 'package:ankh_project/domain/use_cases/get_balance_use_case.dart';
import 'package:ankh_project/feauture/balance_screen/cubit/balance_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/entities/balance_response_entity.dart';
import '../../../../api_service/failure/error_handling.dart';
import '../../../../l10n/app_localizations.dart';

@injectable
class BalanceCubit extends Cubit<BalanceState> {
  final GetBalanceUseCase getBalanceUseCase;

  BalanceCubit({
    required this.getBalanceUseCase,
  }) : super(BalanceInitial());

  Future<void> fetchBalance(BuildContext context, String token) async {
    emit(BalanceLoading());
    var either = await getBalanceUseCase.execute(token);
    either.fold((error) {
      emit(BalanceError(error: error));
    }, (response) {
      if (response == null) {
        emit(BalanceEmpty(message: AppLocalizations.of(context)!.noRequestsFound));
      } else {
        emit(BalanceSuccess(balance: response));
      }
    });
  }
} 