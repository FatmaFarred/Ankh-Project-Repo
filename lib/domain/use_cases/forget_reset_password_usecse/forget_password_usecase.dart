import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../repositries_and_data_sources/repositries/forget_reset_password_repositry.dart';


@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepositry forgetPasswordRepositry;

  ForgetPasswordUseCase(this.forgetPasswordRepositry);

  Future<String?> execute(
    String email) {
    return forgetPasswordRepositry.forgetPassword(email);
  }
}