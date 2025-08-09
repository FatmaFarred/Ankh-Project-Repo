import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/admin_permissions_repositry.dart';
@injectable
class BlockUserUseCase {
  AdminPermissionsRepositry repositry;

  BlockUserUseCase(this.repositry);

  Future<Either<Failure, String?>> blockUser(num days,String reason, String userId) async {
    return await repositry.blockUser(days, reason, userId);


  }
}