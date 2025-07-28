import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../domain/use_cases/unssign_prodcut_from_marketer_use_case.dart';


abstract class MarketerUnassignProductState {}

class MarketerUnassignProductInitial extends MarketerUnassignProductState {}

class MarketerUnassignProductLoading extends MarketerUnassignProductState {}

class MarketerUnassignProductSuccess extends MarketerUnassignProductState {
  final String response;
  MarketerUnassignProductSuccess({required this.response});
}

class MarketerUnassignProductFailure extends MarketerUnassignProductState {
  final Failure error;
  MarketerUnassignProductFailure({required this.error});
}

@injectable
class MarketerUnassignProductCubit extends Cubit<MarketerUnassignProductState> {
  MarketerUnAssignProductUseCase marketerUnassignProductUseCase;

  MarketerUnassignProductCubit(this.marketerUnassignProductUseCase) 
      : super(MarketerUnassignProductInitial());

  Future<void> unassignProduct({required String marketerId,required num productId}) async {
    emit(MarketerUnassignProductLoading());
    var either = await marketerUnassignProductUseCase.execute(productId, marketerId);
    either.fold((error) {
      emit(MarketerUnassignProductFailure(error: error));
    }, (response) {
      emit(MarketerUnassignProductSuccess(response: response??""));
    });
  }
} 