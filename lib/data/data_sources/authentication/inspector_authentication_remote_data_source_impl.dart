import 'package:ankh_project/data/models/login_response_dm.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:io';
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
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspector_authentication_remote_data_course.dart';
import '../../../feauture/authentication/user_controller/user_cubit.dart';
import '../../../firebase_service/firestore_service/firestore_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/global_localization_helper.dart';
import '../../models/authentication_response_dm.dart';
import '../../models/register_response_dm.dart';
import '../../models/user_model.dart';

@Injectable(as: InspectorAuthenticationRemoteDataSource)
class InspectorAuthenticationRemoteDataSourceImpl implements InspectorAuthenticationRemoteDataSource {
  ApiManager apiManager;

  InspectorAuthenticationRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failure, AuthenticationResponseDm>> registerInspector(
      String name,
      String email,
      String password,
      String phone,
      String licenseNumber,
      String vehicleLicenseNumber,
      File licenseImage,
      File vehicleImage,
      String workArea,
      String vehicleType,
  ) async {
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
          "VehicleType": vehicleType,
          "LicenseNumber": licenseNumber ,
          "VehicleLicenseNumber": vehicleLicenseNumber ,
          "WorkArea": workArea ?? "",
          "deviceToken": deviceToken != null ? [deviceToken] : [],
          "LicenseImage": await MultipartFile.fromFile(licenseImage.path),
          "VehicleImage": await MultipartFile.fromFile(vehicleImage.path),

        });



        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.inspectorRegisterEndPoint,
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

          //await FireBaseUtilies.addUser(myUser);

          // Return success
          return right(registerResponse);
        } else {
          return left(ServerError(errorMessage: registerResponse.message));
        }
      } else {
        return left(NetworkError(
            errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e) {
      return left(ServerError(errorMessage: e.toString()));
    }
  }
} 