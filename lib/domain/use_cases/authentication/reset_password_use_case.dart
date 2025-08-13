import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../repositries_and_data_sources/repositries/authentication_repositry.dart';

@injectable
class ResetPasswordUseCase {
  final AuthenticationRepositry authRepository;

  ResetPasswordUseCase(this.authRepository);


  Future<Either<Failure, String?>> execute(
      String email, String newPassword, String code) {
    return authRepository.resetPassword(email, newPassword, code);
  }
}