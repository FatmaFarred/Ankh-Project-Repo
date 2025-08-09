import 'package:ankh_project/domain/entities/all_inspectors_entity.dart';
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/inspector _home_get_all_repositry.dart';
import '../repositries_and_data_sources/repositries/marketer_assign _get_products_repositry.dart';
@injectable

class GetAllInspectorsUseCase{
  HomeGetAllInspectionRepositry repositry;
  GetAllInspectorsUseCase(this.repositry);

  Future <Either<Failure,List<AllInspectorsEntity>>>execute ()async{
    return await repositry.getAllInspectors();

  }


}