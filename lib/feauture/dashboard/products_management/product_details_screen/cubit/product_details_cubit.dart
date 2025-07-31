// lib/feature/product_management_details_screen/cubit/product_details_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_cases/get_product_management_details_usecase.dart';
import 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductManagementDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int id) async {
    emit(ProductDetailsLoading());
    try {
      final result = await getProductDetailsUseCase(id);
      emit(ProductDetailsLoaded(result));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}
