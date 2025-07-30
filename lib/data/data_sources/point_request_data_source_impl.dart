import 'package:ankh_project/api_service/api_manager.dart';

import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_details_remote_data_Source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/end_points.dart';
import '../../api_service/failure/error_handling.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/PointsRemoteDataSource.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/request_point_dm.dart';
@Injectable(as: PointsRemoteDataSource)
class PointRemoteDataSourceImpl implements PointsRemoteDataSource{
  ApiManager apiManager;
  PointRemoteDataSourceImpl(this.apiManager);



  @override
  Future<Either<Failure, String?>> acceptPointRequest(String token, String id) async {
    print('🚀 Starting acceptPointRequest...');

    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.acceptPointRequest}/$id";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');
        print({
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });

        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.acceptPointRequest}/$id",
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
          print('✅ Request successful. Message: ${myResponse['message']}');
          return right(myResponse['message']);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: myResponse.toString()));
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
  Future<Either<Failure, List<RequestPointDm>>> getPointsRequest(String token) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.getPointRequest,

          options: Options(validateStatus: (_) => true),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },

        );


        if (kDebugMode) {
          print( " the response data ${response.data}");
        }




        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;


          final requestResponse = myResponse
              .map((json) => RequestPointDm.fromJson(json))
              .toList();
          // Return success
          return right(requestResponse);
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
  Future<Either<Failure, String?>> rejectPointRequest(String token, String id, String reason) async {

    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.rejectPointRequest}/$id",

          options: Options(validateStatus: (_) => true),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          data: {'reason': reason},

        );



        if (kDebugMode) {
          print( " the response data ${response.data}");
        }
        print('Status code: ${response.statusCode}');
        print('Headers: ${response.headers}');
        print('Raw response: ${response.data}');
        print('Type: ${response.data.runtimeType}');
        final  myResponse = response.data;



        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          // Return success
          return right(response.data['message']);
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


}

