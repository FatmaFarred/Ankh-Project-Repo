import 'package:ankh_project/domain/use_cases/add_point_request_use_case.dart';
import 'package:ankh_project/feauture/balance_screen/cubit/add_point_request_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../api_service/failure/error_handling.dart';
import '../../../../l10n/app_localizations.dart';

@injectable
class AddPointRequestCubit extends Cubit<AddPointRequestState> {
  final AddPointRequestUseCase addPointRequestUseCase;

  AddPointRequestCubit({
    required this.addPointRequestUseCase,
  }) : super(AddPointRequestInitial());

  Future<void> addPointRequest(BuildContext context, String token, String description, num? points,num? commission) async {
    print('Cubit: Adding point request with points: $points');
    emit(AddPointRequestLoading());
    var either = await addPointRequestUseCase.execute(token, description, points, commission);
    either.fold((error) {
      print('Cubit: Error occurred: ${error.errorMessage}');
      emit(AddPointRequestError(error: error));
    }, (response) {
      print('Cubit: Response received: $response');
      if (response == null) {
        emit(AddPointRequestError(error: Failure(errorMessage: AppLocalizations.of(context)!.noRequestsFound)));
      } else {
        emit(AddPointRequestSuccess(message: response));
      }
    });
  }
} 