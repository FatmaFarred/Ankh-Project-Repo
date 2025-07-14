import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/product_details_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../../data/models/all_prosucts_dm.dart';
@injectable
class ProductDetailsUseCase{
  final ProductDetailsRepositry productRepository;

  ProductDetailsUseCase(this.productRepository);

  Future<Either<Failure, AllProductsEntity>> execute(num productId) {
    return productRepository.getProductDetails(productId);
  }
}