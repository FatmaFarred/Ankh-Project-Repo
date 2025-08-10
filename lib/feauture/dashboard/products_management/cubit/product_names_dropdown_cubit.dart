import 'package:ankh_project/domain/entities/product_name_entity.dart';
import 'package:ankh_project/domain/use_cases/get_product_names_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// States
abstract class ProductNamesDropdownState {}

class ProductNamesDropdownInitial extends ProductNamesDropdownState {}

class ProductNamesDropdownLoading extends ProductNamesDropdownState {}

class ProductNamesDropdownLoaded extends ProductNamesDropdownState {
  final List<ProductNameEntity> productNames;

  ProductNamesDropdownLoaded(this.productNames);
}

class ProductNamesDropdownError extends ProductNamesDropdownState {
  final String message;

  ProductNamesDropdownError(this.message);
}

// Cubit
@injectable
class ProductNamesDropdownCubit extends Cubit<ProductNamesDropdownState> {
  final GetProductNamesUseCase getProductNamesUseCase;

  ProductNamesDropdownCubit(this.getProductNamesUseCase)
      : super(ProductNamesDropdownInitial());

  Future<void> loadProductNames() async {
    emit(ProductNamesDropdownLoading());
    try {
      final productNames = await getProductNamesUseCase();
      emit(ProductNamesDropdownLoaded(productNames));
      if (kDebugMode) {
        print('Loaded ${productNames.length} product names for dropdown');
      }
    } catch (e) {
      emit(ProductNamesDropdownError(e.toString()));
      if (kDebugMode) {
        print('Error loading product names for dropdown: $e');
      }
    }
  }
  
  /// Get product names as a list of strings for dropdown
  List<String> getProductNamesAsList() {
    if (state is ProductNamesDropdownLoaded) {
      final loadedState = state as ProductNamesDropdownLoaded;
      return loadedState.productNames.map((product) => product.name).toList();
    }
    return [];
  }

  /// Get product name entity by name
  ProductNameEntity? getProductNameEntityByName(String name) {
    if (state is ProductNamesDropdownLoaded) {
      final loadedState = state as ProductNamesDropdownLoaded;
      return loadedState.productNames.firstWhere(
        (product) => product.name == name,
        orElse: () => ProductNameEntity(id: 0, name: ''),
      );
    }
    return null;
  }
}