import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/di/di.dart';
import '../../../../domain/use_cases/rate_user_use_case.dart';
import 'rate_user_states.dart';

@injectable
class RateUserCubit extends Cubit<RateUserState> {
  final RateUserUseCase _rateUserUseCase;

  RateUserCubit(this._rateUserUseCase) : super(RateUserInitial());

  Future<void> rateUser(String userId, num rate) async {
    emit(RateUserLoading());
    
    final result = await _rateUserUseCase.execute(userId, rate);
    
    result.fold(
      (failure) => emit(RateUserFailure(error: failure)),
      (success) => emit(RateUserSuccess(message: success)),
    );
  }

  void reset() {
    emit(RateUserInitial());
  }
}
