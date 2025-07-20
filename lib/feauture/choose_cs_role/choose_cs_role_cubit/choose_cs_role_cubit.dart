import 'package:ankh_project/domain/entities/cs_roles_response_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../data/models/cs_roles_response_dm.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../../domain/use_cases/cs_roles_usecase.dart';
import 'choose_cs_roles_states.dart';

@injectable
class RoleCsCubit extends Cubit<RoleCsState> {
  CsRolesUseCase csRolesUseCase;
  RoleCsCubit({required this.csRolesUseCase}) : super(RoleCsInitial());

  CsRolesResponseEntity? selectedRole;
  static CsRolesResponseEntity? currentSelectedRole; // Static variable to store current role

  Future<void> fetchRoles() async {
    emit(RoleCsLoading());

    var either = await csRolesUseCase.getCsRoles();

    either.fold((error)  => emit(RoleCsError(error)),

          (response) => emit(RoleCsSuccess(rolesList: response,selectedRole: null)),
    );
  }

  void selectRole(CsRolesResponseEntity role) {
    final currentState = state;

    if (currentState is RoleCsSuccess) {
      selectedRole = role; // Update instance variable
      currentSelectedRole = role; // Save to static variable for global access
      
      print("Selected CS Role: ${role.name}"); // Debug print
      
      emit(RoleCsSuccess(
        rolesList: currentState.rolesList,
        selectedRole: role,
      ));
    }
  }

  // Method to get current selected role
  static CsRolesResponseEntity? getCurrentSelectedRole() {
    return currentSelectedRole;
  }

  // Method to clear current selected role
  static void clearCurrentSelectedRole() {
    currentSelectedRole = null;
    print("Cleared CS Role selection");
  }

  // Method to check if a specific role is selected
  static bool isRoleSelected(String roleName) {
    return currentSelectedRole?.name == roleName;
  }
}