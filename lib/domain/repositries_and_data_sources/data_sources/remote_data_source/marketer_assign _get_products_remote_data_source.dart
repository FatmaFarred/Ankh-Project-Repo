import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/all_products_entity.dart';


abstract class MarketerAssignGetProductsRemoteDataSource{

  Future <Either<Failure,List<AllProductsEntity>>>getMarketerProducts ( String userId );
  Future <Either<Failure,String?>>assignProduct ( num productId,String userId );


}