import 'dart:io';

import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/domain/entities/user_profile_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/end_points.dart';
import '../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/PointsRemoteDataSource.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/profile_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/all_point_price_dm.dart';
import '../models/balance_response_dm.dart';
import '../models/request_point_dm.dart';
import '../models/user_profile_dm.dart';
@Injectable(as: UserProfileRemoteDataSource)
class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  ApiManager apiManager;

  UserProfileRemoteDataSourceImpl(this.apiManager);


  Future<Either<Failure, String?>> editProfile(String token, String userId,
      String fullName, String email, String phone, File image) async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.editProfile}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');
        print("📤 FormData:");
        print("  ➤ Id: $userId");
        print("  ➤ FullName: $fullName");
        print("  ➤ PhoneNumber: $phone");
        print("  ➤ Email: $email");
        print("  ➤ Image Path: ${image.path}");

        FormData formData = FormData.fromMap({
          "Id": userId,
          "FullName": fullName,
          "PhoneNumber": phone,
          "Email": email,
          "Image": await MultipartFile.fromFile(image.path),
        });


        var response = await apiManager.postData(
            url: ApiConstant.baseUrl,
            endPoint: EndPoints.editProfile,
            options: Options(validateStatus: (_) => true),
            headers: {
              'Authorization': 'Bearer $token',
            },
            data: formData

        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');

        final myResponse = response.data;

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print('✅ Request successful. Message: ${myResponse}');
          return right(myResponse);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: myResponse));
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
  Future<Either<Failure, UserProfileDm>> getUserData(String token,
      String userId) async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.getProfile}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');


        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.getProfile}/$userId",
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

        final myResponse = response.data;

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final finalResponse = UserProfileDm.fromJson(myResponse);


          print('✅ Request successful. Message: ${finalResponse}');
          return right(finalResponse);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: myResponse));
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