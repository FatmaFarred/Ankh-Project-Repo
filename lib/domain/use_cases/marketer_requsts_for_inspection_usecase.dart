
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/marketer_requsts_for_inspection_repositry.dart';

@injectable
class MarketerRequestsForInspectionUseCase {
  final MarketerRequestsForInspectionRepositry marketerRequestsRepositry;

  MarketerRequestsForInspectionUseCase(this.marketerRequestsRepositry);

  Future<Either<Failure, List<MarketerRequestsForInspectionEntity>>> execute(String userId, String roleId) async{
    return marketerRequestsRepositry.getAllRequests(userId, roleId) ;
  }
}