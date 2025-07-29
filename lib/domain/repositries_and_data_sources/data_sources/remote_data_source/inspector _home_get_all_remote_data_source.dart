import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/all_inspectors_entity.dart';


abstract class HomeGetAllInspectionRemoteDataSource {

  Future <Either<Failure,List<AllInpectionEntity>>>getHomeAllInspection ( );
  Future <Either<Failure,List<AllInpectionEntity>>>searchAllInspection (String keyWord,String token);
  Future <Either<Failure,String?>>assignProdcutToInspector(num productId, String inspectorId);
  Future <Either<Failure,List<AllInspectorsEntity>>>getAllInspectors ( );
  Future <Either<Failure,List<AllInspectorsEntity>>>searchInspectors (String keyWord);
  Future <Either<Failure,List<AllInpectionEntity>>>getInspectionsByInspectorId (String inspectorId);



}