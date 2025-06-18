
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart';
import '../../../feauture/authentication/user_cubit/user_cubit.dart';
import '../../../firebase_service/firestore_service/firestore_service.dart';
import '../../models/user_model.dart';
@Injectable(as: AuthenticationRemoteDataSource)
 class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {

  Future <MyUser?> register (String name , String email,String password ,)async{
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final deviceToken = await FirebaseMessaging.instance.getToken();

      MyUser myUser= MyUser(uid: credential.user?.uid??"", name: name, email: email,deviceToken:deviceToken??"empty device token" );
      await FireBaseUtilies.addUser(myUser);


      return myUser;

    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw AuthFailure("An unknown error occurred. Please try again later.");
    }
  }

  @override
  Future<MyUser?> signIn(String email, String password) async{
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      MyUser? myUser= await FireBaseUtilies.readUserFromFireStore(credential.user?.uid??"");
      //todo: change the user in presentation layer
      return myUser;
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseException(e);
    } catch (e) {
      throw AuthFailure("An unknown error occurred. Please try again later.");
    }
  }


  }








  AuthFailure _mapFirebaseException(FirebaseAuthException e) {
  switch (e.code) {

    case 'user-not-found':
      return AuthFailure("لم يتم العثور على مستخدم بهذا البريد الإلكتروني.");
    case 'wrong-password':
      return AuthFailure("Wrong password provided.");
    case 'invalid-credential':
      return AuthFailure("البريد الإلكتروني أو كلمة المرور غير صحيحة.");
    case 'network-request-failed':
      return AuthFailure("خطأ في الشبكة. تحقق من اتصالك بالإنترنت.");
    default:
      return AuthFailure(e.message ?? "Authentication failed.");
  }
}



