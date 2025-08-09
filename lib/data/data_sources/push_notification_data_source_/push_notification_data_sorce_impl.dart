import 'dart:io';

import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:ankh_project/domain/entities/notification_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/api_constants.dart';
import '../../../api_service/end_points.dart';
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart';
import '../../../firebase_service/notification_service/local notification.dart';
import '../../../firebase_service/notification_service/push notification_manager.dart';
import '../../../l10n/global_localization_helper.dart';
import '../../models/notification_dm.dart';
@Injectable(as: PushNotificationDataSourse)
class PushNotificationDataSourseImpl implements PushNotificationDataSourse{
  FirebaseMessagingService firebaseMessagingService;
  ApiManager apiManager;

  PushNotificationDataSourseImpl(this.firebaseMessagingService, this.apiManager);


  @override
  Future<void> sendNotificationToAllDevices({required List<String> tokens, required String title, required String body})async {
    try{
      for (final token in tokens) {
        await firebaseMessagingService.sendNotification(targetFcmToken: token, title: title, body: body);
        print("pushNotification is done");
      }
    }catch(e){
      print("failure send notidication:${e.toString()}");


    }
  }

  @override
  Future<Either<Failure, List<NotificationDm>>> getNotification(String userId, String token) async{
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.getNotification}/$userId";
        print('🌐 Full URL: $fullUrl');


        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.getNotification}/$userId",
          options: Options(validateStatus: (_) => true),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },


        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');

        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;
          final requestResponse = myResponse.map((json) => NotificationDm.fromJson(json)).toList();


          print('✅ Request successful. Message: ${requestResponse}');

          return right(requestResponse);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: response.data.toString()));
        }
      } else {
        print('❌ No internet connection!');
        return left(NetworkError(errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e, stackTrace) {
      print('🛑 Exception caught: $e');
      print('📚 Stack trace:\n$stackTrace');
      return left(ServerError(errorMessage: e.toString()));
    }
  }



  @override
  Future<Either<Failure, String?>> postNotification(String userId, String AdminToken, String message, File? image)async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.postNotification}";
        print('🌐 Full URL: $fullUrl');

        FormData formData = FormData.fromMap({
          "UserId": userId,
          "Message": message,
          "ImageFile": image,

        });

        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.postNotification,
          options: Options(validateStatus: (_) => true),
          headers: {
            'Authorization': 'Bearer $AdminToken',
            'Content-Type': 'application/json',
          },
          data: formData,


        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');

        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final  myResponse = response.data;


          print('✅ Request successful. Message: ${myResponse['message']}');

          return right(myResponse['message']);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: response.data.toString()));
        }
      } else {
        print('❌ No internet connection!');
        return left(NetworkError(errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e, stackTrace) {
      print('🛑 Exception caught: $e');
      print('📚 Stack trace:\n$stackTrace');
      return left(ServerError(errorMessage: e.toString()));
    }
  }


}