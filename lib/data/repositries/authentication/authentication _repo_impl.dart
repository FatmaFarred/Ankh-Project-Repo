

 import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositries_and_data_sources/repositries/authentication_repositry.dart';
import '../../models/user_model.dart';
@Injectable(as: RegisterRepositry)
class RegisterRepositryImpl implements RegisterRepositry {
  RegisterRemoteDataSource registerRemoteDataSource ;
  RegisterRepositryImpl(this.registerRemoteDataSource);

  Future <MyUser?> register (String name , String email,String password ,)async{
    return await registerRemoteDataSource.register(name, email, password);

  }


}