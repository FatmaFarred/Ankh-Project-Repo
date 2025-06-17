
import '../../../../data/models/user_model.dart';

abstract class RegisterRemoteDataSource {

  Future <MyUser?> register (String name , String email,String password ,);


}