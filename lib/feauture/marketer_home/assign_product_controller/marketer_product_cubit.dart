import 'package:ankh_project/domain/use_cases/marketer_assign_product_use_case.dart';
import 'package:ankh_project/feauture/marketer_home/assign_product_controller/states.dart';
import 'package:ankh_project/feauture/marketer_products/get_product_controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/marketer_products_use_case.dart';
@injectable

class MarketerAssignProductCubit extends Cubit<MarketerAssignProductState> {
  MarketerAssignProductUseCase  assignProductUseCase;
  num? _currentProductId; // Store the current product ID

  MarketerAssignProductCubit(this.assignProductUseCase) : super(MarketerAssignProductInitial());

  // Getter to access the stored product ID
  num? get currentProductId => _currentProductId;

  Future<void> assignProduct({required num productId,required String userId}) async {
    _currentProductId = productId; // Store the product ID
    emit(MarketerAssignProductLoading());
    var either = await assignProductUseCase.execute(productId, userId);
    either.fold((error) {
      emit(MarketerAssignProductError(error: error));
    }, (response) {
      
          
           emit(MarketerAssignProductSuccess(message: response));

    });
  }
}
