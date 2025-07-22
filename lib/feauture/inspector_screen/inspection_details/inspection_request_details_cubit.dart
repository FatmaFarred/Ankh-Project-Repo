import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/use_cases/get_inspection_request_details_use_case.dart';
import 'inspection_request_details_state.dart';

@injectable
class InspectionRequestDetailsCubit extends Cubit<InspectionRequestDetailsState> {
  final GetInspectionRequestDetailsUseCase _getDetailsUseCase;

  InspectionRequestDetailsCubit(this._getDetailsUseCase)
      : super(InspectionRequestDetailsInitial());

  Future<void> fetchRequestDetails({
    required String token,
    required int requestId,
  }) async {
    emit(InspectionRequestDetailsLoading());
    try {
      final result = await _getDetailsUseCase(
        token: token,
        requestId: requestId,
      );
      emit(InspectionRequestDetailsLoaded(result));
    } catch (e) {
      emit(InspectionRequestDetailsError(e.toString()));
    }
  }
}
