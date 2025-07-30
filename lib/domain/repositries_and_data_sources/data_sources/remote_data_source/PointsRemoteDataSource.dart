import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/all_point_price_entity.dart';
import '../../../entities/request_point_entitty.dart';


abstract class PointsRemoteDataSource {
  Future <Either<Failure,List<RequestPointEntity>>> getPointsRequest(String token);
  Future <Either<Failure,String?>> acceptPointRequest(String token, String id );
  Future <Either<Failure,String?>> rejectPointRequest(String token, String id,String reason );
  Future <Either<Failure,List<AllPointPriceEntity>>> getAllPointPrice();
  Future <Either<Failure,String?>> editPointPrice(String roleName,num price);


}
