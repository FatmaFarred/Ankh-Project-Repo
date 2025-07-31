import 'package:ankh_project/feauture/dashboard/inspection_managemnt/reschedule_states.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/marketer_management_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/get_all_inspection_admin_use_case.dart';
import '../../../domain/use_cases/reschedule_inspection_use_case.dart';
import '../../../domain/use_cases/search_inspection_admin_use_case.dart';

@injectable
class RescheduleCubit extends Cubit<RescheduleStates> {
  RescheduleInspectionUseCase rescheduleInspectionUseCase;
  RescheduleCubit(this.rescheduleInspectionUseCase) : super(RescheduleInspectionInitial());


  Future<void> rescheduleInspection({required String date,required String time,required String adminNote, required num inspectionId }) async {
    emit(RescheduleInspectionLoading());
    // Assuming you have a use case for rescheduling inspections
    var either = await rescheduleInspectionUseCase.execute(date, time, adminNote, inspectionId);
    either.fold((error) {
      emit(RescheduleInspectionError(error: error));
    }, (response) {
      emit(RescheduleInspectionSuccess(message: response??""));
    });
  }

}