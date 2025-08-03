
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../data/models/add_inspection _request.dart';
import '../../entities/marketer_leader_codes_entity.dart';


abstract class MarketerInviteCodeReppositry{

  Future <Either<Failure,List<dynamic>>>generateCode (String token, num count);
  Future <Either<Failure,List<AllMarketersEntity>>>getTeamMembers (String userId);
  Future <Either<Failure,List<MarketerLeaderCodesEntity>>>getAllMarketerGeneratedCode ( String token);

}