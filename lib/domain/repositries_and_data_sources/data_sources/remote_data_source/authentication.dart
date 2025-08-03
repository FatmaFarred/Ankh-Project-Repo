
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../data/models/user_model.dart';
import '../../../entities/authentication_response_entity.dart';
import '../../../entities/login_response_entity.dart';
import '../../../entities/register_response_entity.dart';

abstract class AuthenticationRemoteDataSource {

  Future <Either<Failure,AuthenticationResponseEntity>>register (String name , String email,String password ,String phone);
  Future <Either<Failure,AuthenticationResponseEntity>>signIn (String email,String password );
  Future <Either<Failure,AuthenticationResponseEntity>>registerClient (String name , String email,String password ,String phone);
  Future <Either<Failure,String?>>registerMarketerTeamMember (String name , String email,String password ,String phone,String code);



}