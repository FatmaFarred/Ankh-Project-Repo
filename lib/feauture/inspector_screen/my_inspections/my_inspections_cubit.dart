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

  MyInspectionsCubit({
    required this.getInspectionsUseCase,
    required this.searchProductsUseCase,
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
}
