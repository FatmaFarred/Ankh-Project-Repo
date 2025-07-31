import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/domain/use_cases/get_favorite_use_case.dart';
import 'package:ankh_project/feauture/dashboard/users_management/cubit/user_favorites_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserFavoritesCubit extends Cubit<UserFavoritesState> {
  GetFavoriteUseCase getFavoriteUseCase;

  UserFavoritesCubit(this.getFavoriteUseCase) 
      : super(UserFavoritesInitial());

  Future<void> fetchUserFavorites(String userId) async {
    emit(UserFavoritesLoading());
    var either = await getFavoriteUseCase.execute(userId);
    either.fold((error) {
      emit(UserFavoritesError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(UserFavoritesEmpty())
          : emit(UserFavoritesSuccess(favoritesList: response));
    });
  }
} 