import 'package:ankh_project/domain/entities/authentication_response_entity.dart';
import 'package:ankh_project/feauture/authentication/user_controller/user_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/authentication_response_dm.dart';

@singleton
class UserCubit extends Cubit<UserDm?> {
  UserCubit() : super(null);

  void setUser(UserDm user) {
    emit(user);
  }

  void clearUser() {
    emit(null);
  }
}
