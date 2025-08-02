import 'package:ankh_project/data/models/register_response_dm.dart';
import 'package:ankh_project/domain/entities/register_response_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/authentication_response_entity.dart';
import '../../repositries_and_data_sources/repositries/authentication_repositry.dart';

@injectable
class ClientRegisterUseCase {
  final AuthenticationRepositry authRepository;

  ClientRegisterUseCase(this.authRepository);


  Future<Either<Failure, AuthenticationResponseEntity>> execute(
      String name, String email, String password, String phone) {
    return authRepository.registerClient(name, email, password, phone);
  }
}