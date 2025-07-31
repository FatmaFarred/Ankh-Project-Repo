import 'package:ankh_project/feauture/dashboard/products_management/cubit/product_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/get_product_management_usecase.dart';


@injectable
class ProductsManagementCubit extends Cubit<ProductManagementState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  ProductsManagementCubit(this.getAllProductsUseCase)
      : super(ProductManagementInitial());

  Future<void> fetchAllProducts() async {
    emit(ProductManagementLoading());

    try {
      final products = await getAllProductsUseCase();
      emit(ProductManagementLoaded(products));
    } catch (e) {
      emit(ProductManagementError(e.toString()));
    }
  }
}
