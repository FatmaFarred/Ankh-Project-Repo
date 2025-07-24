
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class MarketerAssignGetProductsRepositry{

  Future <Either<Failure,List<AllProductsEntity>>>getMarketerProducts ( String userId );
  Future <Either<Failure,String?>>assignProduct ( num productId,String userId );

}