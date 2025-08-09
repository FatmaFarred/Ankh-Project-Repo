import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../api_service/failure/error_handling.dart';
import '../../../../../domain/entities/notification_entity.dart';
import '../../../../../domain/use_cases/push_notification_use_case/get_notification_use_case.dart';

part 'get_notification_states.dart';

@injectable
class GetNotificationCubit extends Cubit<GetNotificationState> {
  final GetNotificationUseCase getNotificationUseCase;

  GetNotificationCubit(this.getNotificationUseCase) : super(GetNotificationInitial());

  Future<void> getNotifications({
    required String userId,
    required String token,
  }) async {
    emit(GetNotificationLoading());


      final either = await getNotificationUseCase.execute(userId, token);
      
      either.fold((failure) {
        emit(GetNotificationFailure(error: failure));
      }, (notifications) {
        if (notifications.isEmpty) {
          emit(GetNotificationEmpty());
        } else {
          emit(GetNotificationSuccess(notifications: notifications));
        }
      });

  }
} 