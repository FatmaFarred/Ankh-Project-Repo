
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../data/models/user_model.dart';
import '../../../entities/login_response_entity.dart';
import '../../../entities/register_response_entity.dart';

abstract class AuthenticationRemoteDataSource {

  Future <Either<Failure,RegisterResponseEntity>> register (String name , String email,String password ,String phone,);
  Future <Either<Failure,LoginResponseEntity>> signIn (String email,String password );


}