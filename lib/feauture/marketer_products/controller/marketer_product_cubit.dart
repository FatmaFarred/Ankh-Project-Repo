import 'package:ankh_project/feauture/marketer_products/controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/marketer_products_use_case.dart';
@injectable

class MarketerProductCubit extends Cubit<MarketerProductState> {
  MarketerProductsUseCase  productsUseCase;


  MarketerProductCubit(this.productsUseCase) : super(MarketerProductInitial());

  Future<void> fetchProducts(String userId) async {
    emit(MarketerProductLoading());
    var either = await productsUseCase.getAllMarketerProducts(userId);
    either.fold((error) {
      emit(MarketerProductError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(MarketerProductEmpty())
          : emit(MarketerProductSuccess(requestList: response));

    });
  }
}
