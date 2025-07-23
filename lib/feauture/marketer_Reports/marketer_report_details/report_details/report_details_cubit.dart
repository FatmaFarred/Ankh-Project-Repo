import 'package:ankh_project/feauture/marketer_Reports/marketer_report_details/report_details/report_details_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/use_cases/get_report_details_use_case.dart';

@injectable
class MarketerReportDetailsCubit extends Cubit<MarketerReportDetailsState> {
  final GetReportDetailsUseCase getReportDetailsUseCase;
  MarketerReportDetailsCubit(this.getReportDetailsUseCase) : super(MarketerReportDetailsInitial());

  Future<void> fetchReportDetails({ required num requestId}) async {
    emit(MarketerReportDetailsLoading());
    var either  = await getReportDetailsUseCase.execute(requestId: requestId);
    either.fold(
      (error) => emit(MarketerReportDetailsError(error:error  )),
      (details) => emit(MarketerReportDetailsLoaded(reportDetails: details)),
    );
  }
} 