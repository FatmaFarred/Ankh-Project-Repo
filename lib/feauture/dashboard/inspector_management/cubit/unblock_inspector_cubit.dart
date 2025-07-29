import 'package:ankh_project/domain/use_cases/unblock_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';


abstract class UnblockInspectorState {}

class UnblockInspectorInitial extends UnblockInspectorState {}

class UnblockInspectorLoading extends UnblockInspectorState {}

class UnblockInspectorSuccess extends UnblockInspectorState {
  final String response;
  UnblockInspectorSuccess({required this.response});
}

class UnblockInspectorFailure extends UnblockInspectorState {
  final Failure error;
  UnblockInspectorFailure({required this.error});
}

@injectable
class UnblockInspectorCubit extends Cubit<UnblockInspectorState> {
  UnBlockUserUseCase unblockUserUseCase;

  UnblockInspectorCubit(this.unblockUserUseCase) 
      : super(UnblockInspectorInitial());

  Future<void> unblockInspector(String inspectorId) async {
    emit(UnblockInspectorLoading());
    var either = await unblockUserUseCase.unBlockUser(inspectorId);
    either.fold((error) {
      emit(UnblockInspectorFailure(error: error));
    }, (response) {
      emit(UnblockInspectorSuccess(response: response??""));
    });
  }
} 