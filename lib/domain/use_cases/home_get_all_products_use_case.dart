import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:dartz/dartz.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/product_details_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/home_get_all_products_repositry.dart';
@injectable
class HomeGetAllProductsUseCase {
  HomeGetAllProductsRepositry repository;

  HomeGetAllProductsUseCase(this.repository);

  Future<Either<Failure, List<AllProductsEntity>>> execute() {
    return repository.getHomeAllProducts();
  }

}


























































































































