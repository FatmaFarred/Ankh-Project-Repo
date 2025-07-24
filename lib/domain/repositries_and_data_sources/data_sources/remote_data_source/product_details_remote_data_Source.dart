import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class ProductDetailsRemoteDataSource{

  Future <Either<Failure,ProductDetailsEntity>>getProductDetails ( num productId );

}