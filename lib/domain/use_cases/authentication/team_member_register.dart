import 'package:ankh_project/data/models/register_response_dm.dart';
import 'package:ankh_project/domain/entities/register_response_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/authentication_response_entity.dart';
import '../../repositries_and_data_sources/repositries/authentication_repositry.dart';

@injectable
class TeamMemberRegister {
  final AuthenticationRepositry authRepository;

  TeamMemberRegister(this.authRepository);

  Future<Either<Failure, String?>> execute(
      String name, String email, String password, String phone,String code) {
    return authRepository.registerMarketerTeamMember(name, email, password, phone, code);
  }
}