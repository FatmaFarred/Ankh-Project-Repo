import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/marketer_assign _get_products_repositry.dart';
import 'package:dartz/dartz.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/product_details_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class MarketerProductsUseCase {
  MarketerAssignGetProductsRepositry repository;

  MarketerProductsUseCase(this.repository);

  Future <Either<Failure,List<AllProductsEntity>>> getAllMarketerProducts(
      String userId) {
    return repository.getMarketerProducts(userId);
  }
}