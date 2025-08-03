import 'package:dartz/dartz.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/marketer_leader_codes_entity.dart';
import '../entities/product_details_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/marketer_invite_code_reppositry.dart';
@injectable
class GetAllMarketerCodesUseCase {
  MarketerInviteCodeReppositry repository;

  GetAllMarketerCodesUseCase(this.repository);

  Future<Either<Failure, List<MarketerLeaderCodesEntity>>> execute(String token) {
    return repository.getAllMarketerGeneratedCode(token);
  }

}





