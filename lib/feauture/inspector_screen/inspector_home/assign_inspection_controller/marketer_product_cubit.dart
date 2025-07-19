import 'package:ankh_project/domain/use_cases/marketer_assign_product_use_case.dart';
import 'package:ankh_project/feauture/inspector_screen/inspector_home/assign_inspection_controller/states.dart';
import 'package:ankh_project/feauture/marketer_home/assign_product_controller/states.dart';
import 'package:ankh_project/feauture/marketer_products/get_product_controller/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/inspector_assign_inspection_use_case.dart';
@injectable

class InspectorAssignProductCubit extends Cubit<InspectorAssignProductState> {
  InspectorAssignInspectionUseCase  assignProductUseCase;
  num? _currentProductId; // Store the current product ID

  InspectorAssignProductCubit(this.assignProductUseCase) : super(InspectorAssignProductInitial());

  // Getter to access the stored product ID
  num? get currentProductId => _currentProductId;

  Future<void> assignProduct({required num productId,required String inspectorId}) async {
    _currentProductId = productId; // Store the product ID
    emit(InspectorAssignProductLoading());
    var either = await assignProductUseCase.execute(productId, inspectorId);
    either.fold((error) {
      emit(InspectorAssignProductError(error: error));
    }, (response) {
      
          
           emit(InspectorAssignProductSuccess(message: response));

    });
  }
}
