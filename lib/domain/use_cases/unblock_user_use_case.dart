import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/admin_permissions_repositry.dart';
@injectable
class UnBlockUserUseCase {
   AdminPermissionsRepositry repositry;

   UnBlockUserUseCase(this.repositry);

   Future<Either<Failure, String?>> unBlockUser(String userId) async {
    return await repositry.unBlockUser(userId);


  }
}