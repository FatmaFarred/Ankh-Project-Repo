import 'package:ankh_project/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../repositries_and_data_sources/repositries/authentication_repositry.dart';
@injectable
class SignInUseCase {
  final AuthenticationRepositry authRepository;

  SignInUseCase(this.authRepository);

  Future<MyUser?> execute(String email, String password) {
    return authRepository.signIn(email, password);
  }
}