import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';

class UserCubit extends Cubit<MyUser?> {
  UserCubit() : super(null);

  void changeUser(MyUser newUser) {
    emit(newUser);
  }

  void clearUser() {
    emit(null);
  }
}
