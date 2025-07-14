import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class ProductDetailsRepositry{

  Future <Either<Failure,AllProductsEntity>>getProductDetails (num productId );

}