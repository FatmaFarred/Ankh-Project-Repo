import 'dart:io';

import 'package:ankh_project/domain/entities/user_profile_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_add_request_inspection%20_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../data/models/add_inspection _request.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/profile_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/marketer_add_request_inspection.dart';
import '../../domain/repositries_and_data_sources/repositries/profile_repositry.dart';

@Injectable(as: UserProfileRepositry)
class ProfileRepositryImpl implements UserProfileRepositry {

  UserProfileRemoteDataSource userProfileRemoteDataSource;
  ProfileRepositryImpl({required this.userProfileRemoteDataSource});

  @override
  Future<Either<Failure, String?>> editProfile(String token, String userId, String fullName, String email, String phone, File? image)async {
    var either= await userProfileRemoteDataSource.editProfile(token, userId, fullName, email, phone, image);
    return either.fold((error) => left(error), (response) => right(response));

  }

  @override
  Future<Either<Failure, UserProfileEntity>> getUserData(String token, String userId) async{
    var either= await userProfileRemoteDataSource.getUserData(token, userId);
    return either.fold((error) => left(error), (response) => right(response));


  }

}