import 'package:flutter_bloc/flutter_bloc.dart';

enum CsRole { marketer, inspector, customerService }

class RoleCsCubit extends Cubit<CsRole?> {
  RoleCsCubit() : super(null);

  void selectCsRole(CsRole role) => emit(role);
}
