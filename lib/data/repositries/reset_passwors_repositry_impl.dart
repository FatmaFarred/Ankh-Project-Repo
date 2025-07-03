
import 'package:injectable/injectable.dart';

import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/reset_password_remote_data_sourse.dart';
import '../../domain/repositries_and_data_sources/repositries/reset_password_repositry.dart';
@Injectable(as: ResetPasswordRepositry)
class ResetPasswordsRepositryImpl implements ResetPasswordRepositry {
  ResetPasswordRemoteDataSourse resetPasswordRemoteDataSource;
  ResetPasswordsRepositryImpl(this.resetPasswordRemoteDataSource);

  Future<String?> resetPassword(String email, String token, String password) {
    return resetPasswordRemoteDataSource.resetPassword(email, token, password);


  }



}