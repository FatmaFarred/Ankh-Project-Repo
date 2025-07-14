import 'package:ankh_project/domain/repositries_and_data_sources/repositries/marketer_products_repositry.dart';
import 'package:dartz/dartz.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/all_products_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class MarketerProductsUseCase {
  MarketerProductsRepositry repository;

  MarketerProductsUseCase(this.repository);

  Future<Either<Failure, List<AllProductsEntity>>> getAllMarketerProducts(
      String userId) {
    return repository.getAllMarketerProducts(userId);
  }
}