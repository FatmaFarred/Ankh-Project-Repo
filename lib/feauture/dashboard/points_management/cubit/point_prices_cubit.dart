import 'package:ankh_project/domain/use_cases/get_all_point_price_use_case.dart';
import 'package:ankh_project/domain/use_cases/edit_point_price_use_case.dart';
import 'package:ankh_project/feauture/dashboard/points_management/cubit/point_prices_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../api_service/failure/error_handling.dart';
import '../../../../l10n/app_localizations.dart';

@injectable
class PointPricesCubit extends Cubit<PointPricesState> {
  final GetAllPointPriceUseCase getAllPointPriceUseCase;
  final EditPointPriceUseCase editPointPriceUseCase;

  PointPricesCubit({
    required this.getAllPointPriceUseCase,
    required this.editPointPriceUseCase,
  }) : super(PointPricesInitial());

  Future<void> fetchPointPrices(BuildContext context) async {
    emit(PointPricesLoading());
    var either = await getAllPointPriceUseCase.execute();
    either.fold((error) {
      emit(PointPricesError(error: error));
    }, (response) {
      if (response.isEmpty) {
        emit(PointPricesEmpty(message: AppLocalizations.of(context)!.noRequestsFound));
      } else {
        emit(PointPricesSuccess(pointPrices: response, ));
      }
    });
  }

  Future<void> editPointPrice(  String priceId, double newPrice) async {
    emit(EditPriceLoading());
    var either = await editPointPriceUseCase.execute( priceId, newPrice);
    either.fold((error) {
      emit(EditPriceError(error: error));
    }, (response) {
      emit(EditPriceSuccess(response: response));
    });
  }
} 