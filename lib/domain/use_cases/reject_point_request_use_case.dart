import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/marketer_assign _get_products_repositry.dart';
import '../repositries_and_data_sources/repositries/points_repositry.dart';
@injectable

class RejectPointRequestUseCase{
  PointsRepositry repositry;
  RejectPointRequestUseCase(this.repositry);

  Future <Either<Failure,String?>>execute (String token,String id ,String reason )async{
    return await repositry.rejectPointRequest(token, id, reason);

  }


}