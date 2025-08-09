import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/admin_permissions_repositry.dart';
@injectable
class AppointAsTeamLeaderUseCase {
  AdminPermissionsRepositry repositry;

  AppointAsTeamLeaderUseCase(this.repositry);

  Future<Either<Failure, String?>> appointAsTeamLeader(String userId, String role, String token) async {
    return await repositry.appointAsTeamLeader(userId, role, token);


  }
}