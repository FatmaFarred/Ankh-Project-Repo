import 'package:dartz/dartz.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/request_point_entitty.dart';

abstract class PointsRepositry {
  Future <Either<Failure,List<RequestPointEntity>>> getPointsRequest(String token);
  Future <Either<Failure,String?>> acceptPointRequest(String token, String id );
  Future <Either<Failure,String?>> rejectPointRequest(String token, String id, String reason);

}
