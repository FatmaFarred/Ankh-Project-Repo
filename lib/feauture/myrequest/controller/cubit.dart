import 'package:ankh_project/domain/use_cases/marketer_requsts_for_inspection_usecase.dart';
import 'package:ankh_project/feauture/myrequest/controller/request_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@injectable

class MarketerRequestCubit extends Cubit<MarketerRequestState> {
  MarketerRequestsForInspectionUseCase  requestUseCase;


  MarketerRequestCubit(this.requestUseCase) : super(MarketerRequestInitial());

  Future<void> fetchRequests(String userId, String roleId) async {
    emit(MarketerRequestLoading());
    var either = await requestUseCase.execute(userId, roleId);
    either.fold((error) {
      emit(MarketerRequestError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(MarketerRequestEmpty())
          : emit(MarketerRequestSuccess(requests: response));

    });
  }
}
