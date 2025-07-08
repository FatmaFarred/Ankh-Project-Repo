import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:ankh_project/data/models/marketer_requsts_for_inspection_dm.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/api_constants.dart';
import '../../api_service/end_points.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_requsts_for_inspection_remote_data_sourse.dart';
import '../models/marketer_request_inspection_details_dm.dart';
@Injectable(as: MarketerRequestsForInspectionRemoteDataSource)
class MarkertRequestsForInspectionRemoteDataSourceImpl implements MarketerRequestsForInspectionRemoteDataSource {

  ApiManager apiManager;

  MarkertRequestsForInspectionRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failure, List<MarketerRequestsForInspectionDm>>> getAllRequests(
      String userId, String roleId) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.getMarketerRequests}/$userId",
          queryParameters: {
            'roleId': roleId,
            'userId': userId,
          },
          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }
        final List<dynamic> myResponse = response.data;


        final requestResponse = myResponse
            .map((json) => MarketerRequestsForInspectionDm.fromJson(json))
            .toList();


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          // Return success
          return right(requestResponse);
        } else {
          return left(ServerError(errorMessage: response.data['message']));
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
  Future<Either<Failure, MarketerRequestInspectionDetailsDm>> getRequestDetailsById({required num productId}) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.getMarketerRequestById}/$productId",
          options: Options(validateStatus: (_) => true),
        );

        if (kDebugMode) {
          print(response.data);
        }

        final requestResponse = MarketerRequestInspectionDetailsDm.fromJson(
            response.data);

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          // Return success
          return right(requestResponse);
        } else {
          return left(ServerError(errorMessage: response.data['message']));
        }
      } else {
        return left(NetworkError(
            errorMessage: "No internet connection. Please try again later."));
      }
    } catch (e) {
      return left(ServerError(errorMessage: e.toString()));
    }
  }
}


