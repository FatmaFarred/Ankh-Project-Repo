import 'package:ankh_project/domain/entities/all_users_entity.dart';
import '../../../../api_service/failure/error_handling.dart';

abstract class UsersManagementState {}

class UsersManagementInitial extends UsersManagementState {}

class UsersManagementLoading extends UsersManagementState {}

class UsersManagementSuccess extends UsersManagementState {
  final List<AllUsersEntity> usersList;
  UsersManagementSuccess({required this.usersList});
}

class UsersManagementEmpty extends UsersManagementState {}

class UsersManagementError extends UsersManagementState {
  Failure error;
  UsersManagementError({required this.error});
} 