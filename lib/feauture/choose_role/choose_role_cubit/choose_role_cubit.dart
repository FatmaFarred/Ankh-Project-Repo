import 'package:flutter_bloc/flutter_bloc.dart';

enum UserRole { owner, client, customerService }

class RoleCubit extends Cubit<UserRole?> {
  RoleCubit() : super(null);

  void selectRole(UserRole role) => emit(role);
}
