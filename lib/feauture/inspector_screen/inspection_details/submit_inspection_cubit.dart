import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/inspection_submission_entity.dart';
import '../../../../domain/use_cases/submit_inspection_report_usecase.dart';
import '../../../api_service/failure/error_handling.dart';

part 'submit_inspection_state.dart';



@injectable
class SubmitInspectionCubit extends Cubit<SubmitInspectionState> {
  final SubmitInspectionReportUseCase submitUseCase;

  SubmitInspectionCubit(this.submitUseCase) : super(SubmitInspectionInitial());

  Future<String?> submitReport(InspectionSubmissionEntity entity) async {
    try {
      emit(SubmitInspectionLoading());

      // Call use case → returns Either<Failure, String?>
      final Either<Failure, String?> result = await submitUseCase.call(entity);

      return result.fold(
        // Failure case (Left)
            (failure) {
          final errorMessage = failure.errorMessage;
          emit(SubmitInspectionError(message: errorMessage));
          return null;
        },
        // Success case (Right) → use server message
            (successMessage) {
          final message = successMessage ?? "Inspection report submitted successfully.";
          emit(SubmitInspectionSuccess(message: message));
          return message; // Return the actual server message
        },
      );
    } on Exception catch (e) {
      final errorMessage = e.toString();
      emit(SubmitInspectionError(message: errorMessage));
      return null;
    }
  }}
