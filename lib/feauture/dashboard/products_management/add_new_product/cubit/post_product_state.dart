part of 'post_product_cubit.dart';

@immutable
abstract class PostProductState {}

class PostProductInitial extends PostProductState {}

class PostProductLoading extends PostProductState {}

class PostProductSuccess extends PostProductState {}

class PostProductError extends PostProductState {
  final String message;
  PostProductError(this.message);
}
