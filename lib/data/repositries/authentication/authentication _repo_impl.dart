

 import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositries_and_data_sources/repositries/authentication_repositry.dart';
import '../../models/user_model.dart';

@Injectable(as: AuthenticationRepositry)
class AuthenticationRepositryImpl implements AuthenticationRepositry {
  AuthenticationRemoteDataSource authRemoteDataSource ;
  AuthenticationRepositryImpl(this.authRemoteDataSource);

  Future <MyUser?> register (String name , String email,String password ,)async{
    return await authRemoteDataSource.register(name, email, password);

  }

  Future <MyUser?> signIn (String email,String password ,)async{
    return await authRemoteDataSource.signIn(email, password);

  }

}