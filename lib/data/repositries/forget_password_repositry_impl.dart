
import 'package:injectable/injectable.dart';

import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/forget_reset_password_remote_data_sourse.dart';
import '../../domain/repositries_and_data_sources/repositries/forget_reset_password_repositry.dart';
@Injectable(as: ForgetPasswordRepositry)
class ForgrtPasswordRepositryImpl implements  ForgetPasswordRepositry {
  ForgrtPasswordRemoteDataSource forgetPasswordRemoteDataSource;

  ForgrtPasswordRepositryImpl(this.forgetPasswordRemoteDataSource);
  Future <String?>forgetPassword (String email){
    return forgetPasswordRemoteDataSource.forgetPassword(email);

  }


}