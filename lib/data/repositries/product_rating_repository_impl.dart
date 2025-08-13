import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_rating_remote_data_source.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositories/product_rating_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRatingRepository)
class ProductRatingRepositoryImpl implements ProductRatingRepository {
  final ProductRatingRemoteDataSource productRatingRemoteDataSource;

  ProductRatingRepositoryImpl(this.productRatingRemoteDataSource);

  @override
  Future<Either<Failure, String>> addProductRating({
    required num productId,
    required String userId,
    required num stars,
    required String comment,
    required String token,
  }) async {
    return await productRatingRemoteDataSource.addProductRating(
      productId: productId,
      userId: userId,
      stars: stars,
      comment: comment,
      token: token,
    );
  }
}