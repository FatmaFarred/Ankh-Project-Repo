import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/entities/product_post_entity.dart';
import '../../../../../domain/use_cases/edit_product_usecase.dart';

part 'edit_product_state.dart';

@injectable
class EditProductCubit extends Cubit<EditProductState> {
  final EditProductUseCase editProductUseCase;

  EditProductCubit(this.editProductUseCase) : super(EditProductInitial());

  Future<void> editProduct({
    required int productId,
    required ProductPostEntity entity,
  }) async {
    emit(EditProductLoading());
    try {
      await editProductUseCase.call(productId: productId, entity: entity);
      emit(EditProductSuccess());
    } catch (e) {
      emit(EditProductFailure(e.toString()));
    }
  }
}
