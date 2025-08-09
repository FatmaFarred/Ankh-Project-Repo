import 'package:ankh_project/domain/use_cases/get_all_users_use_case.dart';
import 'package:ankh_project/domain/use_cases/search_users_use_case.dart';
import 'package:ankh_project/feauture/dashboard/users_management/cubit/users_management_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UsersManagementCubit extends Cubit<UsersManagementState> {
  GetAllUsersUseCase getAllUsersUseCase;
  SearchUsersUseCase searchUsersUseCase;

  UsersManagementCubit(this.getAllUsersUseCase, this.searchUsersUseCase) 
      : super(UsersManagementInitial());

  Future<void> fetchUsers() async {
    emit(UsersManagementLoading());
    var either = await getAllUsersUseCase.execute();
    either.fold((error) {
      emit(UsersManagementError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(UsersManagementEmpty())
          : emit(UsersManagementSuccess(usersList: response));
    });
  }

  Future<void> searchUsers(String keyword) async {
    emit(UsersManagementLoading());
    var either = await searchUsersUseCase.execute(keyword);
    either.fold((error) {
      emit(UsersManagementError(error: error));
    }, (response) {
      (response.isEmpty)
          ? emit(UsersManagementEmpty())
          : emit(UsersManagementSuccess(usersList: response));
    });
  }
} 