import 'package:ankh_project/feauture/dashboard/products_management/cubit/product_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/product_management_entity.dart';
import '../../../../domain/use_cases/get_product_management_usecase.dart';


@injectable
class ProductsManagementCubit extends Cubit<ProductManagementState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  
  List<ProductManagementEntity> _allProducts = [];

  ProductsManagementCubit(this.getAllProductsUseCase)
      : super(ProductManagementInitial());

  Future<void> fetchAllProducts() async {
    emit(ProductManagementLoading());

    try {
      _allProducts = await getAllProductsUseCase();
      emit(ProductManagementLoaded(_allProducts));
    } catch (e) {
      emit(ProductManagementError(e.toString()));
    }
  }

  void searchProducts(String query) {
    if (state is ProductManagementLoaded) {
      if (query.isEmpty) {
        emit(ProductManagementLoaded(_allProducts));
      } else {
        final filteredProducts = _allProducts.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
        emit(ProductManagementLoaded(filteredProducts));
      }
    }
  }
}
