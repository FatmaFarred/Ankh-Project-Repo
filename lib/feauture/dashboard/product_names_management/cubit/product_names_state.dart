import 'package:ankh_project/domain/entities/product_name_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProductNamesState extends Equatable {
  const ProductNamesState();

  @override
  List<Object> get props => [];
}

class ProductNamesInitial extends ProductNamesState {}

class ProductNamesLoading extends ProductNamesState {}

class ProductNamesLoaded extends ProductNamesState {
  final List<ProductNameEntity> productNames;

  const ProductNamesLoaded(this.productNames);

  @override
  List<Object> get props => [productNames];
}

class ProductNamesError extends ProductNamesState {
  final String message;

  const ProductNamesError(this.message);

  @override
  List<Object> get props => [message];
}