import 'package:ankh_project/domain/use_cases/add_product_name_use_case.dart';
import 'package:ankh_project/domain/use_cases/delete_product_name_use_case.dart';
import 'package:ankh_project/domain/use_cases/get_product_names_use_case.dart';
import 'package:ankh_project/feauture/dashboard/product_names_management/cubit/product_names_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductNamesCubit extends Cubit<ProductNamesState> {
  final GetProductNamesUseCase getProductNamesUseCase;
  final AddProductNameUseCase addProductNameUseCase;
  final DeleteProductNameUseCase deleteProductNameUseCase;

  ProductNamesCubit(
    this.getProductNamesUseCase,
    this.addProductNameUseCase,
    this.deleteProductNameUseCase,
  ) : super(ProductNamesInitial());

  Future<void> getProductNames() async {
    emit(ProductNamesLoading());
    try {
      final productNames = await getProductNamesUseCase();
      emit(ProductNamesLoaded(productNames));
    } catch (e) {
      emit(ProductNamesError(e.toString()));
    }
  }

  Future<void> searchProductNames(String query) async {
    if (state is ProductNamesLoaded) {
      final allProductNames = (state as ProductNamesLoaded).productNames;
      if (query.isEmpty) {
        // When query is empty, show all product names
        emit(ProductNamesLoaded(allProductNames));
        if (kDebugMode) {
          print('Search field is empty, showing all ${allProductNames.length} product names');
        }
      } else {
        final filteredProductNames = allProductNames
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(ProductNamesLoaded(filteredProductNames));
        if (kDebugMode) {
          print('Searching for: $query, found ${filteredProductNames.length} results');
        }
      }
    } else {
      // If we're not in a loaded state, fetch all product names first
      await getProductNames();
      // Then apply the search if needed
      if (state is ProductNamesLoaded) {
        if (query.isNotEmpty) {
          searchProductNames(query);
        }
        // If query is empty, we already have all product names loaded
      }
    }
  }

  Future<void> addProductName(String name) async {
    if (name.isEmpty) {
      emit(ProductNamesError('Product name cannot be empty'));
      return;
    }

    try {
      emit(ProductNamesLoading());
      await addProductNameUseCase(name);
      await getProductNames(); // Refresh the list after adding
      if (kDebugMode) {
        print('Product name added successfully: $name');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding product name: $e');
      }
      emit(ProductNamesError(e.toString()));
    }
  }
  
  Future<void> deleteProductName(int id) async {
    try {
      emit(ProductNamesLoading());
      await deleteProductNameUseCase(id);
      await getProductNames(); // Refresh the list after deleting
      if (kDebugMode) {
        print('Product name deleted successfully: $id');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting product name: $e');
      }
      emit(ProductNamesError(e.toString()));
    }
  }
}