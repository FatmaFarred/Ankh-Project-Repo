import 'package:ankh_project/domain/use_cases/get_All_inspection_by_id_use_cae.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/all_inpection_entity.dart';
import '../../../domain/use_cases/get_inspections_use_case.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../../domain/use_cases/inspection_home_search_use_case.dart';
import 'my_inspections_state.dart';

@injectable
class MyInspectionsCubit extends Cubit<MyInspectionsState> {
  final GetMyInspectionsUseCase getInspectionsUseCase;
  final InspectorHomeSearchUseCase searchProductsUseCase;
  final GetAllInspectionByIdUseCase getAllInspectionByIdUseCase;

  MyInspectionsCubit({
    required this.getInspectionsUseCase,
    required this.searchProductsUseCase,
    required this.getAllInspectionByIdUseCase,
  }) : super(MyInspectionsInitial());

  Future<void> fetchInspections({
    required String token,
    required String filter,
  }) async {
    emit(MyInspectionsLoading());
    final either = await getInspectionsUseCase.execute(
      token: token,
      filter: filter,
    );
    either.fold((error) => emit(MyInspectionsError(error: error)), (response) {
      (response.isEmpty)
          ? emit(MyInspectionsEmpty())
          : emit(MyInspectionsLoaded(inspections: response));
    });
  }

  Future<void> searchProducts({required keyword, required token}) async {
    emit(MyInspectionsLoading());
    final either = await searchProductsUseCase.execute(keyword, token);
    either.fold((error) => emit(MyInspectionsError(error: error)), (response) {
      (response.isEmpty)
          ? emit(MyInspectionsEmpty())
          : emit(MyInspectionsLoaded(inspections: response));
    });
  }

  /// 🆕 New method for fetching only inspection reports with specific statuses
  Future<void> fetchReports({
    required String token,
    required List<String> filters,
  }) async {
    emit(MyInspectionsLoading());

    try {
      List<AllInpectionEntity> allReports = [];

      for (String filter in filters) {
        print("Fetching reports with filter: $filter");

        final either = await getInspectionsUseCase.execute(
          token: token,
          filter: filter,
        );

        either.fold(
          (error) {
            print(
              "Error fetching reports with filter $filter: ${error.toString()}",
            );
            // Continue with next filter instead of stopping the whole loop
          },
          (response) {
            print("Received ${response.length} reports for filter $filter");
            allReports.addAll(response);
          },
        );
      }

      // Optionally remove duplicates based on `id`
      final uniqueReports = {
        for (var report in allReports) report.id: report,
      }.values.toList();

      if (uniqueReports.isEmpty) {
        emit(MyInspectionsEmpty());
      } else {
        emit(MyInspectionsLoaded(inspections: uniqueReports));
      }
    } catch (e) {
      print("Unexpected error: $e");
      emit(MyInspectionsError(error: ServerError(errorMessage: e.toString())));
    }
  }

  /// 🆕 New method for fetching inspections for a specific inspector
  Future<void> fetchInspectionsByInspectorId({
    required String inspectorId,
    required String token,
  }) async {
    emit(MyInspectionsLoading());
    
    try {
      final either = await getInspectionsUseCase.execute(
        token: token,
        filter: "inspector:$inspectorId", // You might need to adjust this based on your API
      );
      
      either.fold(
        (error) => emit(MyInspectionsError(error: error)),
        (inspections) {
          if (inspections.isEmpty) {
            emit(MyInspectionsEmpty());
          } else {
            emit(MyInspectionsLoaded(inspections: inspections));
          }
        },
      );
    } catch (e) {
      print("Error fetching inspections for inspector $inspectorId: $e");
      emit(MyInspectionsError(error: ServerError(errorMessage: e.toString())));
    }
  }
  Future<void> fetchAllInspectionsById({
  required String inspectorId,
  }) async {
    emit(MyInspectionsLoading());
    final either = await getAllInspectionByIdUseCase.execute(
      inspectorId: inspectorId, // Replace with actual inspector ID

    );
    either.fold((error) => emit(MyInspectionsError(error: error)), (response) {
      (response.isEmpty)
          ? emit(MyInspectionsEmpty())
          : emit(MyInspectionsLoaded(inspections: response));
    });
  }

}
