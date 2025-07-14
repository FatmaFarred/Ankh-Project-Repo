import 'package:ankh_project/domain/use_cases/marketer_requsts_for_inspection_usecase.dart';
import 'package:ankh_project/domain/use_cases/product_details_use_case.dart';
import 'package:ankh_project/feauture/details_screen/controller/product_details_states.dart';
import 'package:ankh_project/feauture/myrequest/controller/request_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@injectable

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsUseCase  productDetailsUseCase;


  ProductDetailsCubit(this.productDetailsUseCase) : super(ProductDetailsInitial());

  Future<void> fetchDetails({required num productId}) async {
    emit(ProductDetailsLoading());
    var either = await productDetailsUseCase.execute(productId);
    either.fold((error) {
      emit(ProductDetailsError(error: error));
    }, (response) {
      emit(ProductDetailsSuccess(productDetails: response));

    });
  }
}
