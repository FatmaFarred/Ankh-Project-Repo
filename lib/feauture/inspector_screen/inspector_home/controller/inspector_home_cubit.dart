import 'package:ankh_project/feauture/inspector_screen/inspector_home/controller/states.dart';
import 'package:ankh_project/feauture/marketer_home/controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/inspection_home_search_use_case.dart';
import '../../../../domain/use_cases/inspector_get_all_inspection_use_case.dart';

@injectable

class InspectorHomeProductCubit extends Cubit<InspectorHomeProductState> {
  InspectorHomeGetAllInspectionUseCase  productsUseCase;
  InspectorHomeSearchUseCase searchProductsUseCase;


  InspectorHomeProductCubit(this.productsUseCase,this.searchProductsUseCase) : super(InspectorHomeProductInitial());

  Future<void> fetchProducts() async {
    emit(InspectorHomeProductLoading());
    var either = await productsUseCase.execute();
    either.fold((error) {
      emit(InspectorHomeProductError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(InspectorHomeProductEmpty())
          : emit(InspectorHomeProductSuccess(productList: response));

    });
  }

  Future<void> searchProducts(String keyword) async {
    emit(InspectorHomeProductLoading());
    var either = await searchProductsUseCase.execute(keyword);
    either.fold((error) {
      emit(InspectorHomeProductError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(InspectorHomeProductEmpty())
          : emit(InspectorHomeProductSuccess(productList: response));
    });
  }
}
