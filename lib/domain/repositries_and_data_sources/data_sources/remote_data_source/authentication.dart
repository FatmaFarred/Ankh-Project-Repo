
import '../../../../data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {

  Future <MyUser?> register (String name , String email,String password ,);
  Future <MyUser?> signIn (String email,String password ,);


}