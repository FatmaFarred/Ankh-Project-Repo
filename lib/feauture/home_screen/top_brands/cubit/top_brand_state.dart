part of 'top_brand_cubit.dart';

abstract class TopBrandState {}

class TopBrandInitial extends TopBrandState {}

class TopBrandLoading extends TopBrandState {}

class TopBrandLoaded extends TopBrandState {
  final List<TopBrandEntity> brands;

  TopBrandLoaded(this.brands);
}

class TopBrandError extends TopBrandState {
  final String message;

  TopBrandError(this.message);
}
