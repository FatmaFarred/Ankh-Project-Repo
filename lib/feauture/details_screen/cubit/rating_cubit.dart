import 'package:ankh_project/domain/use_cases/add_product_rating_use_case.dart';
import 'package:ankh_project/feauture/details_screen/cubit/rating_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RatingCubit extends Cubit<RatingState> {
  final AddProductRatingUseCase addProductRatingUseCase;

  RatingCubit(this.addProductRatingUseCase) : super(RatingInitial());

  Future<void> addProductRating({
    required num productId,
    required String userId,
    required num stars,
    required String comment,
    required String token,
  }) async {
    emit(RatingLoading());

    final result = await addProductRatingUseCase.execute(
      productId: productId,
      userId: userId,
      stars: stars,
      comment: comment,
      token: token,
    );

    result.fold(
      (failure) => emit(RatingError(error: failure)),
      (success) => emit(RatingSuccess(message: success)),
    );
  }

  void resetState() {
    emit(RatingInitial());
  }
}