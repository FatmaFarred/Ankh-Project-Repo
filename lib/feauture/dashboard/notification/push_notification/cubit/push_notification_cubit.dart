import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../api_service/failure/error_handling.dart';
import '../../../../../domain/use_cases/push_notification_use_case/post_notification_use_case.dart';
import '../../../../../domain/use_cases/push_notification_use_case/push_notification_use_case.dart';


part 'push_notification_states.dart';

@injectable
class PushNotificationCubit extends Cubit<PushNotificationState> {
   PushNotificationUseCase pushNotificationUseCase;
   PostNotificationUseCase postNotificationUseCase;


   PushNotificationCubit(this.pushNotificationUseCase,this.postNotificationUseCase) : super(PushNotificationInitial());

  Future<void> sendNotification({
    required String title,
    required String body,
    required List<String> tokens,
  }) async {
    emit(PushNotificationLoading());

    try {

      await pushNotificationUseCase.pushNotificationToAllDevices(
        tokens: tokens,
        title: title,
        body: body,
      );
      print("send notification was called ");
      await Future.delayed(Duration(seconds: 2));
      
      // For now, just print the notification details
      print('📱 Sending notification:');
      print('   Title: $title');
      print('   Body: $body');
      print('   Device Token: $tokens');
      
      emit(PushNotificationSuccess(message: 'تم إرسال الإشعار بنجاح'));
    } catch (e) {
      emit(PushNotificationFailure(errorMessage: e.toString()));
    }
  }
  Future<void> postNotification({
    required String userId,
    required String AdminToken,
    required String message,
    File? image,

  }) async {
    emit(PushNotificationLoading());

    try {
      var either = await postNotificationUseCase.execute(userId, AdminToken, message, image);
      print("send notification to all devices was called ");

      either.fold((error) {
        print("❌ Post notification error: $error");
        emit(PushNotificationFailure(error: error));
      }, (response) {
        print("✅ Post notification success: $response");
        emit(PushNotificationSuccess(message: response));
      });
    } catch (e) {
      print("❌ Post notification exception: $e");
      emit(PushNotificationFailure(errorMessage: e.toString()));
    }
  }

  Future<void> sendNotificationAndPost({
    required String userId,
    required String AdminToken,
    required String message,
    required String title,
    required String body,
    required List<String> tokens,
    File? image,
  }) async {
    emit(PushNotificationLoading());

    try {
      // First, post notification to server
      var either = await postNotificationUseCase.execute(userId, AdminToken, message, image);
      
      either.fold((error) {
        print("❌ Post notification error: $error");
        emit(PushNotificationFailure(error: error));
      }, (response) async {
        print("✅ Post notification success: $response");
        
        // Then, send push notification to devices
        try {
          await pushNotificationUseCase.pushNotificationToAllDevices(
            tokens: tokens,
            title: title,
            body: body,
          );
          print("✅ Push notification sent successfully");
          
          // Emit success with the response message from post notification
          emit(PushNotificationSuccess(message: response));
        } catch (e) {
          print("❌ Push notification error: $e");
          // Even if push fails, we still succeeded in posting to server
          emit(PushNotificationSuccess(message: response));
        }
      });
    } catch (e) {
      print("❌ Combined notification exception: $e");
      emit(PushNotificationFailure(errorMessage: e.toString()));
    }
  }
  }
