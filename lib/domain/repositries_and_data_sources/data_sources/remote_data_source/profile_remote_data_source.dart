import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/user_profile_entity.dart';

abstract class UserProfileRemoteDataSource {
  Future <Either<Failure,UserProfileEntity>> getUserData(String token, String userId);
  Future <Either<Failure,String?>> editProfile(String token, String userId , String fullName, String email, String phone, File image);

}
