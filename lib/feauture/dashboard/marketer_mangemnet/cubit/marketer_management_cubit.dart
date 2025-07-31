import 'package:ankh_project/domain/use_cases/get_all_marketers_use_case.dart';
import 'package:ankh_project/domain/use_cases/search_marketers_use_case.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/marketer_management_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarketerManagementCubit extends Cubit<MarketerManagementState> {
  GetAllMarketersUseCase getAllMarketersUseCase;
  MarketerSearchUseCase searchMarketersUseCase;

  MarketerManagementCubit(this.getAllMarketersUseCase,this.searchMarketersUseCase) : super(MarketerManagementInitial());

  Future<void> fetchMarketers() async {
    emit(MarketerManagementLoading());
    var either = await getAllMarketersUseCase.execute();
    either.fold((error) {
      emit(MarketerManagementError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(MarketerManagementEmpty())
          : emit(MarketerManagementSuccess(marketersList: response));
    });
  }
  Future<void> searchMarketers(String keyword) async {
    emit(MarketerManagementLoading());
    var either = await searchMarketersUseCase.execute(keyword);
    either.fold((error) {
      emit(MarketerManagementError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(MarketerManagementEmpty())
          : emit(MarketerManagementSuccess(marketersList: response));
    });

  }
} 