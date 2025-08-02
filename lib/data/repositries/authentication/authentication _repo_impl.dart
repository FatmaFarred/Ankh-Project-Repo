

 import 'package:ankh_project/data/models/register_response_dm.dart';
import 'package:ankh_project/domain/entities/login_response_entity.dart';
import 'package:ankh_project/domain/entities/register_response_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../../domain/entities/authentication_response_entity.dart';
import '../../../domain/repositries_and_data_sources/repositries/authentication_repositry.dart';
import '../../models/login_response_dm.dart';
import '../../models/user_model.dart';

@Injectable(as: AuthenticationRepositry)
class AuthenticationRepositryImpl implements AuthenticationRepositry {
  AuthenticationRemoteDataSource authRemoteDataSource ;
  AuthenticationRepositryImpl(this.authRemoteDataSource);

  Future <Either<Failure,AuthenticationResponseEntity>> register (String name , String email,String password ,String phone)async{

    var either = await authRemoteDataSource.register(
    name, email, password,  phone);
    return either.fold((error) => left(error), (response) => right(response));
    }

  @override
  Future<Either<Failure, AuthenticationResponseEntity>> signIn(String email, String password) async{
    var either = await authRemoteDataSource.signIn(
        email, password);
    return either.fold((error) => left(error), (response) => right(response));

  }

  Future <Either<Failure,AuthenticationResponseEntity>> registerClient (String name , String email,String password ,String phone)async{

    var either = await authRemoteDataSource.registerClient(
        name, email, password,  phone);
    return either.fold((error) => left(error), (response) => right(response));
  }

  }





