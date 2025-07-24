import 'dart:convert';

import 'package:ankh_project/core/customized_widgets/shared_preferences%20.dart';
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

  Future<void> saveUserData(UserDm user) async {
    final jsonString = jsonEncode(user.toJson());
    await SharedPrefsManager.saveData(key: 'currentUser', value: jsonString);
  }

  Future<void> loadUserFromPrefs() async {
    final jsonString = await SharedPrefsManager.getData(key: 'currentUser');
    if (jsonString != null) {
      final userMap = jsonDecode(jsonString);
      final user = UserDm.fromJson(userMap);
      emit(user);
    }
  }
}
