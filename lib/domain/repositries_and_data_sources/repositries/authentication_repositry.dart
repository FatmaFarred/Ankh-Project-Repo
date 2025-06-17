
import '../../../data/models/user_model.dart';

abstract class RegisterRepositry {

  Future <MyUser?> register (String name , String email,String password ,);


}