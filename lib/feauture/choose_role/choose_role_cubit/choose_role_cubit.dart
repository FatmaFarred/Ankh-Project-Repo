import 'package:flutter_bloc/flutter_bloc.dart';

enum UserRole { owner, Client, customerService, inspector }

class RoleCubit extends Cubit<UserRole?> {
  static UserRole? selectedRole; // Static variable to store selected role
  
  RoleCubit() : super(null);

  void selectRole(UserRole role) {
    selectedRole = role; // Store in static variable
    emit(role);
  }
}
