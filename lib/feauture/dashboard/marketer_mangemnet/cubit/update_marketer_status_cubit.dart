import 'package:ankh_project/domain/use_cases/update_marketer_account_status_use_case.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/update_marketer_status_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateMarketerStatusCubit extends Cubit<UpdateMarketerStatusState> {
  UpdateMarketerAccountStatusUseCase updateMarketerAccountStatusUseCase;

  UpdateMarketerStatusCubit(this.updateMarketerAccountStatusUseCase) 
      : super(UpdateMarketerStatusInitial());

  Future<void> updateMarketerAccountStatus(num status, String userId) async {
    emit(UpdateMarketerStatusLoading());
    var either = await updateMarketerAccountStatusUseCase.execute(status, userId);
    either.fold((error) {
      emit(UpdateMarketerStatusFailure(error: error));
    }, (response) {
      emit(UpdateMarketerStatusSuccess(response: response));
    });
  }
} 