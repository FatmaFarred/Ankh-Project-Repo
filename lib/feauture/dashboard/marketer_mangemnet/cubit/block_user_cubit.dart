import 'package:ankh_project/domain/use_cases/block_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class BlockUserState {}

class BlockUserInitial extends BlockUserState {}

class BlockUserLoading extends BlockUserState {}

class BlockUserSuccess extends BlockUserState {
  final String response;
  BlockUserSuccess({required this.response});
}

class BlockUserFailure extends BlockUserState {
  final Failure error;
  BlockUserFailure({required this.error});
}

@injectable
class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserUseCase blockUserUseCase;

  BlockUserCubit(this.blockUserUseCase) 
      : super(BlockUserInitial());

  Future<void> blockUser(String userId, String reason, int days) async {
    emit(BlockUserLoading());
    var either = await blockUserUseCase.blockUser(days, reason, userId);
    either.fold((error) {
      emit(BlockUserFailure(error: error));
    }, (response) {
      emit(BlockUserSuccess(response: response??""));
    });
  }
} 