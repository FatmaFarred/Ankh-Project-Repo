import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../repositries_and_data_sources/repositries/admin_permissions_repositry.dart';
@injectable
class RateUserUseCase {
  AdminPermissionsRepositry repositry;

  RateUserUseCase(this.repositry);

  Future<Either<Failure, String?>> execute(String userId, num rate) async {
    return await repositry.rateUser(userId, rate);


  }
}