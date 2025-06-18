
import '../../../data/models/user_model.dart';

abstract class AuthenticationRepositry{

  Future <MyUser?> register (String name , String email,String password ,);
  Future <MyUser?> signIn (String email,String password ,);


}