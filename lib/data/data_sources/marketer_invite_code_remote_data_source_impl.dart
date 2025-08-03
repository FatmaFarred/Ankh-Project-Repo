import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/end_points.dart';
import '../../domain/entities/all_marketers_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_invite_code_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/all_marketers_dm.dart';
import '../models/marketer_leader_codes_dm.dart';
@Injectable(as: MarketerInviteCodeRemoteDataSource)

 class MarketerInviteCodeRemoteDataSourceImpl implements MarketerInviteCodeRemoteDataSource {
 ApiManager apiManager;
  MarketerInviteCodeRemoteDataSourceImpl(this.apiManager);

  Future <Either<Failure,List<dynamic>>>generateCode (String token, num count)async{


   try {
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
     if (kDebugMode) {
      print('📤 Sending POST request to: ${ApiConstant.baseUrl}${EndPoints.generateTeamInvitationCode}');
      print('📦 Headers: ${{
       'Authorization': 'Bearer $token',
       'Content-Type': 'application/json',
      }}');

     }

     var response = await apiManager.postData(
      url: ApiConstant.baseUrl,
      endPoint: EndPoints.generateTeamInvitationCode,
      queryParameters: {
       'count': count,
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
      return left(ServerError(errorMessage: response.data.toString()));
     }
    } else {
     return left(NetworkError(
         errorMessage: GlobalLocalization.noInternet));
    }
   } catch (e) {
    return left(ServerError(errorMessage: e.toString()));
   }

  }

  Future <Either<Failure,List<AllMarketersDm>>>getTeamMembers (String userId)async{


   try {
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
     if (kDebugMode) {
      print('📤 Sending POST request to: ${ApiConstant.baseUrl}${EndPoints.getTeamByLeaderId}/$userId');


     }

     var response = await apiManager.getData(
      url: ApiConstant.baseUrl,
      endPoint: '${EndPoints.getTeamByLeaderId}/$userId',




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
      final List<dynamic> myResponse = response.data;
      final requestResponse = myResponse
          .map((json) => AllMarketersDm.fromJson(json))
          .toList();

      return right(requestResponse);
     } else {
      return left(ServerError(errorMessage: response.data.toString()));
     }
    } else {
     return left(NetworkError(
         errorMessage: GlobalLocalization.noInternet));
    }
   } catch (e) {
    return left(ServerError(errorMessage: e.toString()));
   }

  }
  Future <Either<Failure,List<MarketerLeaderCodesDm>>>getAllMarketerGeneratedCode ( String token)async{
   try {
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
     if (kDebugMode) {
      print('📤 Sending POST request to: ${ApiConstant.baseUrl}${EndPoints.getAllInvitesCodeByLeaderId}');
      print('📦 Headers: ${{
       'Authorization': 'Bearer $token',
       'Content-Type': 'application/json',
      }}');
      }


     var response = await apiManager.getData(
      url: ApiConstant.baseUrl,
      endPoint: EndPoints.getAllInvitesCodeByLeaderId,

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
      final List<dynamic> myResponse = response.data;
      final requestResponse = myResponse.map((json) => MarketerLeaderCodesDm.fromJson(json)).toList();



      return right(requestResponse);
     } else {
      return left(ServerError(errorMessage: response.data.toString()));
     }
    }

     else {
     return left(NetworkError(
         errorMessage: GlobalLocalization.noInternet));
    }
   } catch (e) {
    return left(ServerError(errorMessage: e.toString()));
   }

  }

}