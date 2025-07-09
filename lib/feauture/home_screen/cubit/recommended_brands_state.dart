part of 'recommended_brands_cubit.dart';

abstract class RecommendedBrandsState {}

class RecommendedBrandsInitial extends RecommendedBrandsState {}

class RecommendedBrandsLoading extends RecommendedBrandsState {}

class RecommendedBrandsLoaded extends RecommendedBrandsState {
  final List<ProductEntity> products;

  RecommendedBrandsLoaded(this.products);
}

class RecommendedBrandsError extends RecommendedBrandsState {
  final String message;

  RecommendedBrandsError(this.message);
}
