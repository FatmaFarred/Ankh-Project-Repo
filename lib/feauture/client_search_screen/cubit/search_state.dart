import '../../../domain/entities/all_products_entity.dart';

abstract class AllProductsSearchState {}

class AllProductsInitial extends AllProductsSearchState {}

class AllProductsLoading extends AllProductsSearchState {}

class AllProductsLoaded extends AllProductsSearchState {
  final List<AllProductsEntity> allProducts;
  final List<AllProductsEntity> filteredProducts;

  AllProductsLoaded({
    required this.allProducts,
    required this.filteredProducts,
  });
}

class AllProductsEmpty extends AllProductsSearchState {}

class AllProductsError extends AllProductsSearchState {
  final String message;

  AllProductsError(this.message);
}
