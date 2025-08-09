import 'package:ankh_project/domain/use_cases/add_favorite_use_case.dart';
import 'package:ankh_project/domain/use_cases/delete_favorite_use_case.dart';
import 'package:ankh_project/feauture/authentication/register/controller/register_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'add_remove_favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteToggleState> {
  final AddFavoriteUseCase addFavoriteUseCase;
  final DeleteFavoriteUseCase deleteFavoriteUseCase;




  FavoriteCubit(this.addFavoriteUseCase, this.deleteFavoriteUseCase) : super(FavoriteInitial());



  Future<void> addFavorite({required String userId,required num productId}) async {

    emit(FavoriteLoading());

    var either = await addFavoriteUseCase.execute(userId, productId);
    either.fold((error) {
      emit(FavoriteFailure(error: error));
    }, (response) {
      emit(FavoriteSuccess(response: response??""));
    });
  }
  Future<void> removeFavorite({required String userId,required num productId}) async {

    emit(FavoriteLoading());

    var either = await deleteFavoriteUseCase.execute(userId, productId);
    either.fold((error) {
      emit(FavoriteFailure(error: error));
    }, (response) {
      emit(FavoriteSuccess(response: response??""));
    });
  }

}
