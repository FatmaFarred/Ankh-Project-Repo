import 'package:ankh_project/domain/use_cases/get_all_marketers_use_case.dart';
import 'package:ankh_project/domain/use_cases/search_marketers_use_case.dart';
import 'package:ankh_project/feauture/dashboard/inspection_managemnt/states.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/marketer_management_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/get_all_inspection_admin_use_case.dart';
import '../../../domain/use_cases/reschedule_inspection_use_case.dart';
import '../../../domain/use_cases/search_inspection_admin_use_case.dart';

@injectable
class InspectionManagementCubit extends Cubit<InspectionManagementState> {
  GetAllInspectionAdminUseCase getAllInspectionAdminUseCase;
  SearchInspectionAdminUseCase searchInspectionAdminUseCase;
  InspectionManagementCubit(this.getAllInspectionAdminUseCase,this.searchInspectionAdminUseCase) : super(InspectionManagementInitial());

  Future<void> fetchInspections() async {
    emit(InspectionManagementLoading());
    var either = await getAllInspectionAdminUseCase.execute();
    either.fold((error) {
      emit(InspectionManagementError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(InspectionManagementEmpty())
          : emit(InspectionManagementSuccess(inspectionsList: response));
    });
  }
  Future<void> searchInspections(String keyword) async {
    emit(InspectionManagementLoading());
    var either = await searchInspectionAdminUseCase.execute(keyword);
    either.fold((error) {
      emit(InspectionManagementError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(InspectionManagementEmpty())
          : emit(InspectionManagementSuccess(inspectionsList: response));
    });

  }

}