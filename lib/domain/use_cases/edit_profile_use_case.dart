import 'dart:io';

import 'package:ankh_project/domain/repositries_and_data_sources/repositries/profile_repositry.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
@injectable
class EditProfileUseCase{
  UserProfileRepositry repositry;
  EditProfileUseCase(this.repositry);

  Future <Either<Failure,String?>>execute (String token,String userId,String fullName,String email,String phone,File image)async{
    return await repositry.editProfile(token, userId, fullName, email, phone, image);

  }


}