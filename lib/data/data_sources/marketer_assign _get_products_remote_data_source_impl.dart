import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../api_service/api_constants.dart';
import '../../api_service/end_points.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_assign _get_products_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/all_marketers_dm.dart';
import '../models/all_products_dm.dart';
import '../models/product_details_dm.dart';


@Injectable(as: MarketerAssignGetProductsRemoteDataSource)
 class MarketerAssignGetProductsRemoteDataSourceImpl implements MarketerAssignGetProductsRemoteDataSource {
  ApiManager apiManager;

  MarketerAssignGetProductsRemoteDataSourceImpl(this.apiManager);

  Future <Either<Failure, List<AllProductsDm>>> getMarketerProducts(
      String userId) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.getMarketerProductsById}/$userId",

          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;


          final requestResponse = myResponse
              .map((json) => AllProductsDm.fromJson(json))
              .toList();

          // Return success
          return right(requestResponse);
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
  Future<Either<Failure, String?>> assignProduct(num productId, String userId)async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.marketerAssignProduct,
          queryParameters:{"productId":productId,
          "marketerId": userId
          } ,

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

  @override
  Future<Either<Failure, List<AllMarketersDm>>> getAllMarketers() async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.getAllMarketers,

          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;


          final requestResponse = myResponse
              .map((json) => AllMarketersDm.fromJson(json))
              .toList();

          // Return success
          return right(requestResponse);
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
  Future<Either<Failure, String?>> updateMarketerAccountStatus(num status, String userId) async{
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.putData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.updateMarketerAccountStatus,
          data:{"marketerId":userId,
            "status": status
          } ,

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

  @override
  Future<Either<Failure, List<AllMarketersDm>>> searchMarketer(String keyWord)async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.searchMarketer,
          queryParameters: {"search": keyWord},

          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;


          final requestResponse = myResponse
              .map((json) => AllMarketersDm.fromJson(json))
              .toList();

          // Return success
          return right(requestResponse);
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