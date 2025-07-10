import 'package:ankh_project/data/models/login_response_dm.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/api_constants.dart';
import '../../../api_service/api_manager.dart';
import '../../../api_service/di/di.dart';
import '../../../api_service/end_points.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../../core/customized_widgets/shared_preferences .dart';
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart';
import '../../../feauture/authentication/user_controller/user_cubit.dart';
import '../../../firebase_service/firestore_service/firestore_service.dart';
import '../../models/authentication_response_dm.dart';
import '../../models/register_response_dm.dart';
import '../../models/user_model.dart';

@Injectable(as: AuthenticationRemoteDataSource)
class AuthenticationRemoteDataSourceImplWithApi implements AuthenticationRemoteDataSource {
  ApiManager apiManager;

  AuthenticationRemoteDataSourceImplWithApi(this.apiManager);

  @override
  Future<Either<Failure, AuthenticationResponseDm>> register(String name,
      String email, String password, String phone) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final deviceToken = await FirebaseMessaging.instance.getToken();


        FormData formData = FormData.fromMap({
          "Name": name,
          "Email": email,
          "Password": password,
          "Phone": phone,
          "deviceToken": deviceToken != null ? [deviceToken] : [],
        });

        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.marketerRegisterEndPoint,
          data: formData,
        );

        if (kDebugMode) {
          print(response.data);
        }

        var registerResponse = AuthenticationResponseDm.fromJson(response.data);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {


          // Save user to Firestore
          UserDm myUser = UserDm(
            id: registerResponse.user?.id,
            fullName: name,
            email: email,
            phoneNumber: phone,
            deviceTokens: deviceToken != null ? [deviceToken] : [],
            roles: registerResponse.user?.roles
          );

          await FireBaseUtilies.addUser(myUser);

          // Return success
          return right(registerResponse);
        } else {
          return left(ServerError(errorMessage: registerResponse.message));
        }
      } else {
        return left(NetworkError(
            errorMessage: "No internet connection. Please try again later."));
      }
    } catch (e) {
      return left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponseDm>> signIn(String email,
      String password) async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        final deviceToken = await FirebaseMessaging.instance.getToken();


        var response = await apiManager.postData(endPoint: EndPoints.loginEndPoint,
          url: ApiConstant.baseUrl,
          data: {
            "email": email,
            "password": password,
            "deviceToken": deviceToken != null ? [deviceToken] : [],
          },);
        var loginResponse = AuthenticationResponseDm.fromJson(response.data);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          UserDm myUser = UserDm(
              id: loginResponse.user?.id,
              fullName: loginResponse.user?.fullName,
              email: email,
              phoneNumber:  loginResponse.user?.phoneNumber,
              deviceTokens: deviceToken != null ? [deviceToken] : [],
              roles: loginResponse.user?.roles
          );
          final userCubit = getIt<UserCubit>();
          userCubit.setUser(myUser);
          print("User logged in: ${myUser.fullName}");
          await SharedPrefsManager.saveData(key: 'user_token', value: loginResponse.token);


          return right(loginResponse);
        } else {
          return left(ServerError(errorMessage: loginResponse.message));
        }
      } else {
        return left(
            NetworkError(errorMessage: "No internet connection. Please try again later."));
      }
    }
    catch (e) {
      return left(NetworkError(errorMessage: e.toString()));
    }
  }
}

