import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/end_points.dart';
import '../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_add_request_inspection _data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/add_inspection _request.dart';

@Injectable(as: MarketerAddRequestInspectionRemoteDataSource)
class MarketerAddRequestInspectionRemoteDataSourseImpl
    implements MarketerAddRequestInspectionRemoteDataSource {
  ApiManager apiManager;
  MarketerAddRequestInspectionRemoteDataSourseImpl({required this.apiManager});


  Future<Either<Failure, String?>> addRequest(InspectionRequest request) async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity()
          .checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.MarketerAddRequestIspection,
          data:request.toJson() ,

          options: Options(validateStatus: (_) => true),
        );

        if (kDebugMode) {
          print(response.data);
        }
        final myResponse = response.data;


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          // Return success
          return right(myResponse);
        } else {
          return left(ServerError(errorMessage: response.data['message']));
        }
      } else {
        return left(NetworkError(errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e) {
      return left(ServerError(errorMessage: e.toString()));
    }
  }
}
