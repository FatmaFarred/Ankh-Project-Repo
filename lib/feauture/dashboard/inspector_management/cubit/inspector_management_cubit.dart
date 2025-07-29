import 'package:ankh_project/domain/use_cases/get_all_insepctors_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ankh_project/domain/use_cases/search_inspectors_use_case.dart';
import 'package:ankh_project/domain/entities/all_inspectors_entity.dart';

import '../../../../api_service/failure/error_handling.dart';

part 'inspector_management_states.dart';

@injectable
class InspectorManagementCubit extends Cubit<InspectorManagementState> {
  final GetAllInspectorsUseCase getAllInspectorsUseCase;
  final SearchInspectorsUseCase searchInspectorsUseCase;

  InspectorManagementCubit(
    this.getAllInspectorsUseCase,
    this.searchInspectorsUseCase,
  ) : super(InspectorManagementInitial());

  Future<void> getAllInspectors() async {
    emit(InspectorManagementLoading());

      final result = await getAllInspectorsUseCase.execute();
      result.fold(
        (error) => emit(InspectorManagementFailure(error)),
        (inspectors) {
          if (inspectors.isEmpty) {
            emit(InspectorManagementEmpty());
          } else {
            emit(InspectorManagementSuccess(inspectors));
          }
        },
      );

  }

  Future<void> searchInspectors({required String keyWord} ) async {

    emit(InspectorManagementLoading());
      final result = await searchInspectorsUseCase.execute(keyWord: keyWord);
      result.fold(
        (error) => emit(InspectorManagementFailure(error)),
        (inspectors) {
          if (inspectors.isEmpty) {
            emit(InspectorManagementEmpty());
          } else {
            emit(InspectorManagementSuccess(inspectors));
          }
        },
      );

  }
} 