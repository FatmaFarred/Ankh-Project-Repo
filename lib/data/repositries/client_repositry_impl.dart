import 'dart:io';

import 'package:ankh_project/domain/entities/all_users_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/client_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/client_repositry.dart';

@Injectable(as: ClientRepositry)
 class ClientRepositryImpl implements ClientRepositry {
   ClientRemoteDataSource clientRemoteDataSource;
  ClientRepositryImpl({required this.clientRemoteDataSource});

  Future <Either<Failure,List<AllUsersEntity>>> getAllUsers()async{
    var either = await clientRemoteDataSource.getAllUsers();
    return either.fold((error) => left(error), (response) => right(response));

  }

  Future <Either<Failure,List<ProductDetailsEntity>>> getUserFavourite( String userId )async{
    var either = await clientRemoteDataSource.getUserFavourite(userId);
    return either.fold((error) => left(error), (response) => right(response));

  }

  Future <Either<Failure,List<AllUsersEntity>>> searchUsers(String keyword) async {
    var either = await clientRemoteDataSource.searchUsers(keyword);
    return either.fold((error) => left(error), (response) => right(response));
  }



}
