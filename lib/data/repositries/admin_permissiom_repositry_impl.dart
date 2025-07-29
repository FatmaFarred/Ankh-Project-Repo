
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/admin_permission_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../../data/models/user_model.dart';
import '../../domain/repositries_and_data_sources/repositries/admin_permissions_repositry.dart';

@Injectable(as: AdminPermissionsRepositry)
 class AdminPermissionsRepositryimpl implements AdminPermissionsRepositry {
  AdminPermissionsRemoteDataSource adminPermissionsRemoteDataSource;
  AdminPermissionsRepositryimpl(this.adminPermissionsRemoteDataSource);

  Future <Either<Failure,String?>>blockUser (num days,String reason, String userId) async {
    var either = await adminPermissionsRemoteDataSource.blockUser(days, reason, userId);
    return either.fold((error) => left(error), (response) => right(response));

  }
  Future <Either<Failure,String?>>unBlockUser (String userId)
  async {
    var either = await adminPermissionsRemoteDataSource.unBlockUser(userId);
    return either.fold((error) => left(error), (response) => right(response));

  }
  Future <Either<Failure,String?>>appointAsTeamLeader (String userId, String role, String token)
  async {
    var either = await adminPermissionsRemoteDataSource.appointAsTeamLeader(userId, role, token);
    return either.fold((error) => left(error), (response) => right(response));

  }



}