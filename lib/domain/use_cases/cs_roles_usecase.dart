
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../entities/cs_roles_response_entity.dart';
@injectable

 class CsRolesUseCase{
CsRolesRepositry csRolesRepositry;
CsRolesUseCase(this.csRolesRepositry);

  Future <Either<Failure,List<CsRolesResponseEntity>>>getCsRoles ()async{
    return await csRolesRepositry.getCsRoles();

  }


}