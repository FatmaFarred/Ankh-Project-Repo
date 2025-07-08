import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../domain/entities/marketer_request_inspection_details_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_requsts_for_inspection_remote_data_sourse.dart';
import '../../domain/repositries_and_data_sources/repositries/marketer_requsts_for_inspection_repositry.dart';

@Injectable(as: MarketerRequestsForInspectionRepositry)
 class MarketerRequestsForInspectionRepositryImpl implements MarketerRequestsForInspectionRepositry {
  MarketerRequestsForInspectionRemoteDataSource marketerRequestsForInspectionRemoteDataSource;
  MarketerRequestsForInspectionRepositryImpl(this.marketerRequestsForInspectionRemoteDataSource);

  Future <Either<Failure,List<MarketerRequestsForInspectionEntity>>>getAllRequests ( String userId ,String roleId,)async{
    var either = await marketerRequestsForInspectionRemoteDataSource.getAllRequests(userId, roleId);
    return either.fold((error) => left(error), (response) => right(response));



  }
  Future <Either<Failure,MarketerRequestInspectionDetailsEntity>>getRequestDetailsById (
      { required num productId})async{
    var either = await marketerRequestsForInspectionRemoteDataSource.getRequestDetailsById(productId: productId);
    return either.fold((error) => left(error), (response) => right(response));

  }


}