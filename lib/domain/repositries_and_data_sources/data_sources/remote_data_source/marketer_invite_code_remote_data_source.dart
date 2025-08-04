
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/all_marketers_entity.dart';
import '../../../entities/marketer_leader_codes_entity.dart';

abstract class MarketerInviteCodeRemoteDataSource{

  Future <Either<Failure,List<dynamic>>>generateCode (String token, num count);
  Future <Either<Failure,List<AllMarketersEntity>>>getTeamMembers (String userId);
  Future <Either<Failure,List<MarketerLeaderCodesEntity>>>getAllMarketerGeneratedCode ( String token);

}