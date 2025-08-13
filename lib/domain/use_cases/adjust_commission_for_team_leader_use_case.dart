import 'package:ankh_project/domain/repositries_and_data_sources/repositries/points_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
@injectable
class AdjustCommissionForTeamLeaderUseCase{
  PointsRepositry repositry;
  AdjustCommissionForTeamLeaderUseCase(this.repositry);

  Future <Either<Failure,String?>>execute (String token, num commissionRate)async{
    return await repositry.adjustCommissionForTeamLeader(token, commissionRate);

  }


}