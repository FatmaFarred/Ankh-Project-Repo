
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';



abstract class AdminPermissionsRemoteDataSource {

  Future <Either<Failure,String?>>blockUser (num days,String reason, String userId);
  Future <Either<Failure,String?>>unBlockUser (String userId);
  Future <Either<Failure,String?>>appointAsTeamLeader (String userId, String role, String token);
  Future <Either<Failure,String?>> rateUser(String userId, num rate);



}