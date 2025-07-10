
import 'package:injectable/injectable.dart';

import '../../repositries_and_data_sources/repositries/reset_password_repositry.dart';

@injectable
class ResetPasswordUseCase {
  final ResetPasswordRepositry resetPasswordRepositry;

  ResetPasswordUseCase(this.resetPasswordRepositry);

  Future<String?> execute(String email, String token, String newPassword) {
    return resetPasswordRepositry.resetPassword(email, token, newPassword);;
  }
}