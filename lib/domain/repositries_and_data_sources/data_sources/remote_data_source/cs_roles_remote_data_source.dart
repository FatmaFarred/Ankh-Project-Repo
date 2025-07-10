
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/cs_roles_response_entity.dart';



abstract class CsRolesRemoteDataSource{

  Future <Either<Failure,List<CsRolesResponseEntity>>>getCsRoles ();


}