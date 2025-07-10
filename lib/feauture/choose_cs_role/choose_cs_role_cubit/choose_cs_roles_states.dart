
import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:ankh_project/domain/entities/cs_roles_response_entity.dart';

import '../../../data/models/cs_roles_response_dm.dart';

abstract class RoleCsState {}

class RoleCsInitial extends RoleCsState {}

class RoleCsLoading extends RoleCsState {}

class RoleCsSuccess extends RoleCsState {
  final List<CsRolesResponseEntity> rolesList;
  final CsRolesResponseEntity? selectedRole;

  RoleCsSuccess({required this.rolesList, this.selectedRole});
}
class RoleCsError extends RoleCsState {
  Failure error;
  RoleCsError(this.error);
}


