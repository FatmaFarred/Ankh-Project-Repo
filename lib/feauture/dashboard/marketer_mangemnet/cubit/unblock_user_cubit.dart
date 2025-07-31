import 'package:ankh_project/domain/use_cases/unblock_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class UnblockUserState {}

class UnblockUserInitial extends UnblockUserState {}

class UnblockUserLoading extends UnblockUserState {}

class UnblockUserSuccess extends UnblockUserState {
  final String response;
  UnblockUserSuccess({required this.response});
}

class UnblockUserFailure extends UnblockUserState {
  final Failure error;
  UnblockUserFailure({required this.error});
}

@injectable
class UnblockUserCubit extends Cubit<UnblockUserState> {
  UnBlockUserUseCase unblockUserUseCase;

  UnblockUserCubit(this.unblockUserUseCase) 
      : super(UnblockUserInitial());

  Future<void> unblockUser(String userId) async {
    emit(UnblockUserLoading());
    var either = await unblockUserUseCase.unBlockUser(userId);
    either.fold((error) {
      emit(UnblockUserFailure(error: error));
    }, (response) {
      emit(UnblockUserSuccess(response: response??""));
    });
  }
} 