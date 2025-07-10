
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../domain/entities/cs_roles_response_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/cs_roles_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart';

@Injectable(as: CsRolesRepositry)
 class CsRolesRepositryImpl implements CsRolesRepositry {

  CsRolesRemoteDataSource csRolesRemoteDataSource;
  CsRolesRepositryImpl(this.csRolesRemoteDataSource);
  Future <Either<Failure,List<CsRolesResponseEntity>>>getCsRoles ()async{
    var either= await  csRolesRemoteDataSource.getCsRoles();
    return either.fold((error) => left(error), (response) => right(response));



  }


}