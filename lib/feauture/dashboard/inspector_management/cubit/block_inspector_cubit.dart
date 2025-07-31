import 'package:ankh_project/domain/use_cases/block_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class BlockInspectorState {}

class BlockInspectorInitial extends BlockInspectorState {}

class BlockInspectorLoading extends BlockInspectorState {}

class BlockInspectorSuccess extends BlockInspectorState {
  final String response;
  BlockInspectorSuccess({required this.response});
}

class BlockInspectorFailure extends BlockInspectorState {
  final Failure error;
  BlockInspectorFailure({required this.error});
}

@injectable
class BlockInspectorCubit extends Cubit<BlockInspectorState> {
  BlockUserUseCase blockUserUseCase;

  BlockInspectorCubit(this.blockUserUseCase) 
      : super(BlockInspectorInitial());

  Future<void> blockInspector(String inspectorId, String reason, int days) async {
    emit(BlockInspectorLoading());
    var either = await blockUserUseCase.blockUser(days, reason, inspectorId);
    either.fold((error) {
      emit(BlockInspectorFailure(error: error));
    }, (response) {
      emit(BlockInspectorSuccess(response: response??""));
    });
  }
} 