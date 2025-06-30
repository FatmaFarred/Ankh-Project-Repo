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
import '../../../api_service/end_points.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart';
import '../../../feauture/authentication/user_cubit/user_cubit.dart';
import '../../../firebase_service/firestore_service/firestore_service.dart';
import '../../models/register_response_dm.dart';
import '../../models/user_model.dart';

@Injectable(as: AuthenticationRemoteDataSource)
class AuthenticationRemoteDataSourceImplWithApi implements AuthenticationRemoteDataSource {
  ApiManager apiManager;

  AuthenticationRemoteDataSourceImplWithApi(this.apiManager);

  @override
  Future<Either<Failure, RegisterResponseDm>> register(String name,
      String email, String password, String phone) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        FormData formData = FormData.fromMap({
          "Name": name,
          "Email": email,
          "Password": password,
          "Phone": phone,
        });

        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.marketerRegisterEndPoint,
          data: formData,
        );

        if (kDebugMode) {
          print(response.data);
        }

        var registerResponse = RegisterResponseDm.fromJson(response.data);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          // Register in Firebase Auth
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);

          // Get device token
          final deviceToken = await FirebaseMessaging.instance.getToken();

          // Save user to Firestore
          MyUser myUser = MyUser(
            uid: credential.user?.uid ?? "",
            name: name,
            email: email,
            deviceTokens: deviceToken != null ? [deviceToken] : [],
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
  Future<Either<Failure, LoginResponseDm>> signIn(String email,
      String password) async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(endPoint: EndPoints.loginEndPoint,
          url: ApiConstant.baseUrl,
          data: {
            "email": email,
            "password": password
          },);
        var loginResponse = LoginResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
         /* final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          final deviceToken = await FirebaseMessaging.instance.getToken();
          await FireBaseUtilies.addDeviceTokenToUser(
            credential.user?.uid ?? "",
            deviceToken ?? "",
          );
          MyUser? myUser = await FireBaseUtilies.readUserFromFireStore(
            credential.user?.uid ?? "",
          );
*/
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

