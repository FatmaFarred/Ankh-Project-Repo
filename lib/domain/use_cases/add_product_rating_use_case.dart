import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositories/product_rating_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductRatingUseCase {
  final ProductRatingRepository productRatingRepository;

  AddProductRatingUseCase(this.productRatingRepository);

  Future<Either<Failure, String>> execute({
    required num productId,
    required String userId,
    required num stars,
    required String comment,
    required String token,
  }) async {
    return await productRatingRepository.addProductRating(
      productId: productId,
      userId: userId,
      stars: stars,
      comment: comment,
      token: token,
    );
  }
}