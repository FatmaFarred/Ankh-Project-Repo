part of 'products_by_brand_cubit.dart';

abstract class ProductsByBrandState {}

class ProductsByBrandInitial extends ProductsByBrandState {}

class ProductsByBrandLoading extends ProductsByBrandState {}

class ProductsByBrandLoaded extends ProductsByBrandState {
  final List<AllProductsEntity> products;

  ProductsByBrandLoaded(this.products);
}

class ProductsByBrandEmpty extends ProductsByBrandState {}

class ProductsByBrandError extends ProductsByBrandState {
  final String message;

  ProductsByBrandError(this.message);
}