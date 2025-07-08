
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/marketer_request_inspection_details_entity.dart';
import '../../../entities/marketer_requests_for_inspection_entity.dart';


abstract class MarketerRequestsForInspectionRemoteDataSource {

  Future <Either<Failure,List<MarketerRequestsForInspectionEntity>>>getAllRequests ( String userId ,String roleId,);
  Future <Either<Failure,MarketerRequestInspectionDetailsEntity>>getRequestDetailsById (
      { required num productId});


}