import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/points_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/all_point_price_entity.dart';
import '../repositries_and_data_sources/repositries/marketer_assign _get_products_repositry.dart';
@injectable
class EditPointPriceUseCase{
  PointsRepositry repositry;
  EditPointPriceUseCase(this.repositry);

  Future <Either<Failure,String?>>execute ( String roleName, num price)async{
    return await repositry.editPointPrice(roleName, price);

  }


}