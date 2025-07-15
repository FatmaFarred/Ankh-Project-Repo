import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../api_service/failure/error_handling.dart';
import '../../../../data/models/add_inspection _request.dart';


abstract class MarketerAddRequestInspectionRemoteDataSource {

  Future <Either<Failure,String?>>addRequest (InspectionRequest request  );

}