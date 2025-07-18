import 'package:ankh_project/feauture/marketer_home/controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/home_get_all_products_use_case.dart';
import '../../../domain/use_cases/marketer_products_use_case.dart';
import '../../../domain/use_cases/marketer_serach_home_usecase.dart';
@injectable

class MarketerHomeProductCubit extends Cubit<MarketerHomeProductState> {
  HomeGetAllProductsUseCase  productsUseCase;
  MarketerSearchProductsUseCase searchProductsUseCase;


  MarketerHomeProductCubit(this.productsUseCase,this.searchProductsUseCase) : super(MarketerHomeProductInitial());

  Future<void> fetchProducts() async {
    emit(MarketerHomeProductLoading());
    var either = await productsUseCase.execute();
    either.fold((error) {
      emit(MarketerHomeProductError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(MarketerHomeProductEmpty())
          : emit(MarketerHomeProductSuccess(productList: response));

    });
  }

  Future<void> searchProducts(String keyword) async {
    emit(MarketerHomeProductLoading());
    var either = await searchProductsUseCase.execute(keyword);
    either.fold((error) {
      emit(MarketerHomeProductError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(MarketerHomeProductEmpty())
          : emit(MarketerHomeProductSuccess(productList: response));
    });
  }
}
