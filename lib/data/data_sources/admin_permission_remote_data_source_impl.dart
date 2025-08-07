
import 'package:ankh_project/data/models/cs_roles_response_dm.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/end_points.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/admin_permission_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/cs_roles_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';

@Injectable(as: AdminPermissionsRemoteDataSource)
class AdminPermissionsRemoteDataSourceImpl implements AdminPermissionsRemoteDataSource {
  ApiManager apiManager;

  AdminPermissionsRemoteDataSourceImpl(this.apiManager);

  Future <Either<Failure,String?>>blockUser (num days,String reason, String userId)async{
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.blockUser}/$userId",
          data: {
            'isPermanent': false,
            'days': days,
            'reason': reason,
          },

          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }



        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final  myResponse = response.data;



          return right(myResponse['message']);
        } else {
          return left(ServerError(errorMessage: response.data['message']));
        }
      } else {
        return left(NetworkError(
            errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e) {
      return left(ServerError(errorMessage: e.toString()));
    }
  }


  @override
  Future<Either<Failure, String?>> unBlockUser(String userId) async {
      try {
        final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

        if (connectivityResult.contains(ConnectivityResult.wifi) ||
            connectivityResult.contains(ConnectivityResult.mobile)) {
          var response = await apiManager.postData(
            url: ApiConstant.baseUrl,
            endPoint:"${EndPoints.unBlockUser}/$userId",

            options: Options(validateStatus: (_) => true),

          );

          if (kDebugMode) {
            print(response.data);
          }



          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            final  myResponse = response.data;



            return right(myResponse['message']);
          } else {
            return left(ServerError(errorMessage: response.data['message']));
          }
        } else {
          return left(NetworkError(
              errorMessage: GlobalLocalization.noInternet));
        }
      } catch (e) {
        return left(ServerError(errorMessage: e.toString()));
      }
    }




  @override
  Future<Either<Failure, String?>> appointAsTeamLeader(String userId, String role, String token)async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        if (kDebugMode) {
          print('📤 Sending POST request to: ${ApiConstant.baseUrl}${EndPoints.appointAsTeamLeader}');
          print('📦 Headers: ${{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }}');
          print('📨 Payload: ${{
            'userId': userId,
            'newRole': role,
          }}');
        }

        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.appointAsTeamLeader,
          data: {
            'userId': userId,
            'newRole': role,
          },
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },


          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print('✅ Status Code: ${response.statusCode}');
          print('📥 Raw Response Data: ${response.data}');
          print('🧾 Response Type: ${response.data.runtimeType}');
          print(response.data);
        }


        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final  myResponse = response.data;



          return right(myResponse);
        } else {
          return left(ServerError(errorMessage: response.data));
        }
      } else {
        return left(NetworkError(
            errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e) {
      return left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> rateUser(String userId, num rate) async{
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        if (kDebugMode) {
          print('📤 Sending POST request to: ${ApiConstant.baseUrl}${EndPoints.rateUser}');

        }

        var response = await apiManager.putData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.rateUser,
          data: {
            "rating": rate,
            "userId": userId
          },


          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print('✅ Status Code: ${response.statusCode}');
          print('📥 Raw Response Data: ${response.data}');
          print('🧾 Response Type: ${response.data.runtimeType}');
          print(response.data);
        }



        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final  myResponse = response.data;



          return right(myResponse['message'] );
        } else {
          return left(ServerError(errorMessage: response.data['message'] ));
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
