import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/home_get_all_products_repositry.dart';

@injectable
class MarketerSearchProductsUseCase {
  HomeGetAllProductsRepositry repository;

  MarketerSearchProductsUseCase(this.repository);

  Future<Either<Failure, List<AllProductsEntity>>> execute(String keyWord) {
    return repository.searchAllProducts(keyWord);
  }

}

