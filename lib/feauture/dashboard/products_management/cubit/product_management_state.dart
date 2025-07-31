// lib/feature/product_management/cubit/product_management_state.dart

import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product_management_entity.dart';

abstract class ProductManagementState extends Equatable {
  const ProductManagementState();

  @override
  List<Object?> get props => [];
}

class ProductManagementInitial extends ProductManagementState {}

class ProductManagementLoading extends ProductManagementState {}

class ProductManagementLoaded extends ProductManagementState {
  final List<ProductManagementEntity> products;

  const ProductManagementLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductManagementError extends ProductManagementState {
  final String message;

  const ProductManagementError(this.message);

  @override
  List<Object?> get props => [message];
}
