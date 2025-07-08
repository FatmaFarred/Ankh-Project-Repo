import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/marketer_request_inspection_details_entity.dart';
import '../repositries_and_data_sources/repositries/marketer_requsts_for_inspection_repositry.dart';

@injectable
class MarketerRequestsInspectionDetailsUseCase {
  final MarketerRequestsForInspectionRepositry marketerRequestsRepositry;

  MarketerRequestsInspectionDetailsUseCase(this.marketerRequestsRepositry);
  Future <Either<Failure,MarketerRequestInspectionDetailsEntity>>getRequestDetailsById ({ required num productId})async{
    return marketerRequestsRepositry.getRequestDetailsById(productId: productId) ;
  }
}