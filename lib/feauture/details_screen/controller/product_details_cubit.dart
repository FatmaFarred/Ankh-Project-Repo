import 'package:ankh_project/domain/use_cases/marketer_requsts_for_inspection_usecase.dart';
import 'package:ankh_project/domain/use_cases/product_details_use_case.dart';
import 'package:ankh_project/feauture/dashboard/users_management/cubit/user_favorites_cubit.dart';
import 'package:ankh_project/feauture/details_screen/controller/product_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/di/di.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../dashboard/users_management/cubit/user_favorites_states.dart';
@injectable

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsUseCase  productDetailsUseCase;


  ProductDetailsCubit(this.productDetailsUseCase) : super(ProductDetailsInitial());

  Future<void> fetchDetails({required num productId}) async {
    emit(ProductDetailsLoading());
    var either = await productDetailsUseCase.execute(productId);
    either.fold((error) {
      emit(ProductDetailsError(error: error));
    }, (response) async{
      final user = getIt<UserCubit>().state;
      final String? userId = user?.id;

      bool isFavorited = false;

      if (userId != null) {
        // Fetch user's favorites
        final favoritesCubit = getIt<UserFavoritesCubit>();
        await favoritesCubit.fetchUserFavorites(userId);

        final favoritesState = favoritesCubit.state;
        if (favoritesState is UserFavoritesSuccess) {
          isFavorited = favoritesState.favoritesList
              .any((item) => item.productId == productId);
        }
      }
      emit(ProductDetailsSuccess(productDetails: response,
        isFavorite: isFavorited,

      ));

    });
  }
}
