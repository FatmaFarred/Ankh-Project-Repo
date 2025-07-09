part of "popular_product_cubit.dart";


abstract class PopularProductsState {}

class PopularProductsInitial extends PopularProductsState {}

class PopularProductsLoading extends PopularProductsState {}

class PopularProductsLoaded extends PopularProductsState {
  final List<ProductEntity> products;
  PopularProductsLoaded(this.products);
}

class PopularProductsError extends PopularProductsState {
  final String message;
  PopularProductsError(this.message);
}
