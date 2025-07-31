// lib/feature/dashboard/products_management/cubit/product_details_state.dart

import 'package:equatable/equatable.dart';
import '../../../../../domain/entities/product_management_details_entity.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductManagementDetailsEntity product;

  const ProductDetailsLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
