import 'package:ankh_project/domain/entities/product_details_entity.dart';
import '../../../../api_service/failure/error_handling.dart';

abstract class UserFavoritesState {}

class UserFavoritesInitial extends UserFavoritesState {}

class UserFavoritesLoading extends UserFavoritesState {}

class UserFavoritesSuccess extends UserFavoritesState {
  final List<ProductDetailsEntity> favoritesList;
  UserFavoritesSuccess({required this.favoritesList});
}

class UserFavoritesEmpty extends UserFavoritesState {}

class UserFavoritesError extends UserFavoritesState {
  Failure error;
  UserFavoritesError({required this.error});
} 