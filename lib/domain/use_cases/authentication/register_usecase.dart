import 'package:ankh_project/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../repositries_and_data_sources/repositries/authentication_repositry.dart';
@injectable
class RegisterUseCase {
  final RegisterRepositry authRepository;

  RegisterUseCase(this.authRepository);

  Future<MyUser?> execute(String email, String password,String name) {
    return authRepository.register(name, email, password);
  }
}