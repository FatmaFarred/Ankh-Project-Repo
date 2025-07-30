import 'package:ankh_project/domain/entities/all_point_price_entity.dart';
import 'package:ankh_project/domain/entities/balance_response_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../domain/entities/request_point_entitty.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/PointsRemoteDataSource.dart';
import '../../domain/repositries_and_data_sources/repositries/points_repositry.dart';
  @Injectable(as: PointsRepositry)
 class Pointsrepositryimpl implements PointsRepositry {
    PointsRemoteDataSource pointsRemoteDataSource;
  Pointsrepositryimpl(this.pointsRemoteDataSource);

  Future <Either<Failure,List<RequestPointEntity>>> getPointsRequest(String token)async{
    var either = await pointsRemoteDataSource.getPointsRequest(token);
    return either.fold((error) => left(error), (response) => right(response));


  }
  Future <Either<Failure,String?>> acceptPointRequest(String token, String id ) async {
    var either = await pointsRemoteDataSource.acceptPointRequest(token, id);
    return either.fold((error) => left(error), (response) => right(response));
  }
  Future <Either<Failure,String?>> rejectPointRequest(String token, String id,String reason ) async {
    var either = await pointsRemoteDataSource.rejectPointRequest(token, id, reason);
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, String?>> editPointPrice(String roleName, num price) async{
    var either = await pointsRemoteDataSource.editPointPrice(roleName, price);
    return either.fold((error) => left(error), (response) => right(response));

  }

  @override
  Future<Either<Failure, List<AllPointPriceEntity>>> getAllPointPrice()async {
    var either = await pointsRemoteDataSource.getAllPointPrice();
    return either.fold((error) => left(error), (response) => right(response));

  }

  @override
  Future<Either<Failure, String?>> addPointRequest(String token, String description, num points)async {
    var either = await pointsRemoteDataSource.addPointRequest(token, description, points);
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, BalanceResponseEntity>> getBalance(String token)async {
    var either = await pointsRemoteDataSource.getBalance(token);
    return either.fold((error) => left(error), (response) => right(response));
  }


}
