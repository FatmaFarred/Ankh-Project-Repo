import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class HomeGetAllInspectionRepositry{

  Future <Either<Failure,List<AllInpectionEntity>>>getHomeAllInspection ( );
  Future <Either<Failure,List<AllInpectionEntity>>>searchAllInspection (String keyWord,String token);
  Future <Either<Failure,String?>>assignProdcutToInspector(num productId, String inspectorId);



}