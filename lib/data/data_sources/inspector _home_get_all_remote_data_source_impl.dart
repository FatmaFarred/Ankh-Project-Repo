
import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/end_points.dart';
import '../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspector _home_get_all_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/all_inpection_dm.dart';
import '../models/all_products_dm.dart';

@Injectable(as: HomeGetAllInspectionRemoteDataSource)

class HomeGetAllInspectionRemoteDataSourceImpl implements HomeGetAllInspectionRemoteDataSource {

  ApiManager apiManager;

  HomeGetAllInspectionRemoteDataSourceImpl(this.apiManager);

  Future <Either<Failure, List<AllInpectionDm>>> getHomeAllInspection() async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.inspectorGetAllInspection,


          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }
        final List<dynamic> myResponse = response.data;


        final requestResponse = myResponse
            .map((json) => AllInpectionDm.fromJson(json))
            .toList();


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
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

  Future <Either<Failure, List<AllInpectionDm>>> searchAllInspection(String keyWord,String token) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {

        final originalInput = keyWord.trim();       // Keep Arabic/English characters intact
        final lowerInput = originalInput.toLowerCase();  // Use for logic checks
        String? search = '';
        String? status = '';
        String? date = '';

        final dateInputRegex = RegExp(r'^\d{1,2}-\d{1,2}-\d{4}$'); // Accepts 22-7-2025 or 01-01-2025
        const knownStatuses = ['Pending', 'Completed', 'Rejected', 'Cancelled','Not Responded', 'Postponed', 'In Progress'];

        if (dateInputRegex.hasMatch(lowerInput)) {
          try {
            final parsedDate = DateFormat('d-M-yyyy').parseStrict(originalInput);
            date = DateFormat('yyyy-MM-dd').format(parsedDate);
          } catch (e) {
            return left(ServerError(errorMessage: "Invalid date format. Use dd-MM-yyyy."));
          }
        } else if (knownStatuses.contains(lowerInput)) {
          status = lowerInput;
        // Convert Arabic or lowercase to backend status
        } else {
          search = originalInput; // ✅ Accept Arabic or English name
        }

        print("Search: $search, Status: $status, Date: $date");
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.searchHomeInspection,
          queryParameters: {
            'Search': search,
            'Status': status,
            'Date': date,
          },
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }
        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;
          final requestResponse = myResponse.map((json) =>
              AllInpectionDm.fromJson(json))
              .toList();
          // Return success
          return right(requestResponse);
        }
        else {
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
  Future<Either<Failure, String?>> assignProdcutToInspector(num productId, String inspectorId) async{
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.inspectorAssignInspection,
          data: {
            "requestId": productId,
            "inspectorId": inspectorId
          },


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

