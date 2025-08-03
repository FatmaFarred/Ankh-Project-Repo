import 'package:dartz/dartz.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../domain/entities/all_marketers_entity.dart';
import '../../domain/entities/marketer_leader_codes_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_invite_code_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/marketer_invite_code_reppositry.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: MarketerInviteCodeReppositry)
 class MarketerInviteCodeRepositryImpl implements MarketerInviteCodeReppositry {
  MarketerInviteCodeRemoteDataSource marketerInviteCodeRemoteDataSource;
  MarketerInviteCodeRepositryImpl(this.marketerInviteCodeRemoteDataSource);

  Future <Either<Failure,List<dynamic>>>generateCode (String token, num count)async{
    var either =await marketerInviteCodeRemoteDataSource.generateCode(token, count);
    return either.fold((error) => left(error), (response) => right(response));


  }
  Future <Either<Failure,List<AllMarketersEntity>>>getTeamMembers (String userId)async{
    var either =await marketerInviteCodeRemoteDataSource.getTeamMembers(userId);
    return either.fold((error) => left(error), (response) => right(response));


  }
  Future <Either<Failure,List<MarketerLeaderCodesEntity>>>getAllMarketerGeneratedCode ( String token) async {
    var either =await marketerInviteCodeRemoteDataSource.getAllMarketerGeneratedCode(token);
    return either.fold((error) => left(error), (response) => right(response));
  }

}