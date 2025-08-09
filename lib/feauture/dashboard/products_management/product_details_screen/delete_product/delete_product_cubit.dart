  import 'package:bloc/bloc.dart';
  import 'package:equatable/equatable.dart';
  import 'package:injectable/injectable.dart';

  import '../../../../../domain/use_cases/delete_product_usecase.dart';

  part 'delete_product_state.dart';

  @injectable
  class DeleteProductCubit extends Cubit<DeleteProductState> {
    final DeleteProductUseCase deleteProductUseCase;

    DeleteProductCubit(this.deleteProductUseCase) : super(DeleteProductInitial());

    Future<void> deleteProduct(int productId) async {
      emit(DeleteProductLoading());

      try {
        await deleteProductUseCase(productId);
        emit(DeleteProductSuccess());
      } catch (e) {
        emit(DeleteProductFailure(e.toString()));
      }
    }
  }
