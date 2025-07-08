import 'package:ankh_project/domain/use_cases/marketer_request_inspection_details_usecase.dart';
import 'package:ankh_project/domain/use_cases/marketer_requsts_for_inspection_usecase.dart';
import 'package:ankh_project/feauture/myrequest/my_request_details/details_controller/request_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@injectable

class MarketerRequestDetailsCubit extends Cubit<MarketerRequestDetailsState> {
  MarketerRequestsInspectionDetailsUseCase  requestDetailsUseCase;


  MarketerRequestDetailsCubit(this.requestDetailsUseCase) : super(MarketerRequestDetailsInitial());

  Future<void> fetchRequests({ required num productId } ) async {
    emit(MarketerRequestDetailsLoading());
    var either = await requestDetailsUseCase.getRequestDetailsById(productId: productId);
    either.fold((error) {
      emit(MarketerRequestDetailsError(error: error));
    }, (response) {

           emit(MarketerRequestDetailsSuccess(requestDetails: response));

    });
  }
}
