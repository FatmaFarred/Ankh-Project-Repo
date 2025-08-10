import 'package:dartz/dartz.dart';
import 'package:ankh_project/api_service/failure/error_handling.dart';

abstract class ProductRatingRepository {
  Future<Either<Failure, String>> addProductRating({
    required num productId,
    required String userId,
    required num stars,
    required String comment,
    required String token,
  });
}