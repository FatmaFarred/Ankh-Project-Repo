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
   GetMyInspectionsUseCase getInspectionsUseCase;
   InspectorHomeSearchUseCase searchProductsUseCase;


   MyInspectionsCubit({required this.getInspectionsUseCase,required this.searchProductsUseCase}) : super(MyInspectionsInitial());

  Future<void> fetchInspections({required String token, required String filter}) async {
    emit(MyInspectionsLoading());
    var either = await getInspectionsUseCase.execute(token: token, filter: filter);
    either.fold(
      (error) => emit(MyInspectionsError(error: error)),
      (response) {
        (response.isEmpty)
            ? emit(MyInspectionsEmpty())
            : emit(MyInspectionsLoaded(inspections: response));
      } );
  }

   Future<void> searchProducts({ required keyword, required token}) async {
     emit(MyInspectionsLoading());
     var either = await searchProductsUseCase.execute(keyword,token);
     either.fold((error) {
       emit(MyInspectionsError(error: error));
     }, (response) {
       (response.isEmpty)
           ? emit(MyInspectionsEmpty())
           : emit(MyInspectionsLoaded(inspections: response));
     });
   }


} 