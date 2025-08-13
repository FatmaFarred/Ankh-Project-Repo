import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../repositries_and_data_sources/repositries/authentication_repositry.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthenticationRepositry authRepository;

  ForgetPasswordUseCase(this.authRepository);


  Future<Either<Failure, String?>> execute(
      String email) {
    return authRepository.forgetPassword(email);
  }
}