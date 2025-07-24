import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/inspection_submission_entity.dart';
import '../../../../domain/use_cases/submit_inspection_report_usecase.dart';

part 'submit_inspection_state.dart';

@injectable
class SubmitInspectionCubit extends Cubit<SubmitInspectionState> {
  final SubmitInspectionReportUseCase submitUseCase;

  SubmitInspectionCubit(this.submitUseCase) : super(SubmitInspectionInitial());

  Future<void> submitReport(InspectionSubmissionEntity entity) async {
    try {
      emit(SubmitInspectionLoading());
      await submitUseCase(entity);
      emit(SubmitInspectionSuccess());
    } catch (e) {
      emit(SubmitInspectionError(e.toString()));
    }
  }
}
