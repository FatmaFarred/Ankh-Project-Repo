import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/push_notification_use_case/push_notification_use_case.dart';
@injectable
class PushNotificationCubit extends Cubit<void> {
  final PushNotificationUseCase pushNotificationUseCase;

  PushNotificationCubit(this.pushNotificationUseCase) : super(null);

  Future<void> sendNotificationToAll({
    required List<String> tokens,
    required String title,
    required String body,
  }) async {
    try {
      await pushNotificationUseCase.pushNotificationToAllDevices(
        tokens: tokens,
        title: title,
        body: body,
      );
    } catch (e) {
      print(" Error sending notification: ${e.toString()}");
    }
  }
}
