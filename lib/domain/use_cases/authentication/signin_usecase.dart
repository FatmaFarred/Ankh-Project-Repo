import 'package:ankh_project/data/models/user_model.dart';
import 'package:ankh_project/domain/entities/login_response_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/authentication_response_entity.dart';
import '../../entities/register_response_entity.dart';
import '../../repositries_and_data_sources/repositries/authentication_repositry.dart';
@injectable
class SignInUseCase {
  final AuthenticationRepositry authRepository;

  SignInUseCase(this.authRepository);

  Future <Either<Failure,AuthenticationResponseEntity>>execute(String email, String password) {
    return authRepository.signIn(email, password);
  }
}