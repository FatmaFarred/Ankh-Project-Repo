import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/domain/entities/all_point_price_entity.dart';
import 'package:ankh_project/domain/entities/all_users_entity.dart';
import 'package:ankh_project/domain/entities/balance_response_entity.dart';

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
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/client_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/all_point_price_dm.dart';
import '../models/all_users_dm.dart';
import '../models/balance_response_dm.dart';
import '../models/product_details_dm.dart';
import '../models/request_point_dm.dart';
@Injectable(as: ClientRemoteDataSource)
class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  ApiManager apiManager;

  ClientRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failure, List<AllUsersDm>>> getAllUsers()async {
      print('🚀 Starting acceptPointRequest...');

    try {
    print('🔌 Checking internet connection...');
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.wifi) ||
    connectivityResult.contains(ConnectivityResult.mobile)) {
    print('✅ Internet connected via ${connectivityResult.join(", ")}');

    final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.getAllUsers}/$id";
    print('🌐 Full URL: $fullUrl');



    var response = await apiManager.getData(
    url: ApiConstant.baseUrl,
    endPoint:EndPoints.getAllUsers,
    options: Options(validateStatus: (_) => true),

    );

    print('📥 Response received!');
    print('🔢 Status code: ${response.statusCode}');
    print('📦 Headers: ${response.headers}');
    print('📨 Raw body: ${response.data}');
    print('🔍 Response type: ${response.data.runtimeType}');


    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final List<dynamic> myResponse = response.data;
      final requestResponse = myResponse
          .map((json) => AllUsersDm.fromJson(json)).toList();


      print('✅ Request successful. Message: ${requestResponse}');

    return right(requestResponse);
    } else {
    print('⚠️ Request failed with status ${response.statusCode}');
    return left(ServerError(errorMessage: response.data.toString()));
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
  Future<Either<Failure, List<ProductDetailsDm>>> getUserFavourite(String userId) async{
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.getUserFavourite}";
        print('🌐 Full URL: $fullUrl');



        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint:EndPoints.getUserFavourite,
          queryParameters: {'userId': userId},
          options: Options(validateStatus: (_) => true),

        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;
          final requestResponse = myResponse
              .map((json) => ProductDetailsDm.fromJson(json)).toList();


          print('✅ Request successful. Message: ${requestResponse}');

          return right(requestResponse);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: response.data.toString()));
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
  Future<Either<Failure, List<AllUsersEntity>>> searchUsers(String keyword)async {
    print('🚀 Starting acceptPointRequest...');

    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.searchUsers}";
        print('🌐 Full URL: $fullUrl');



        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint:EndPoints.searchUsers,
          queryParameters: {'search': keyword},
          options: Options(validateStatus: (_) => true),

        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;
          final requestResponse = myResponse
              .map((json) => AllUsersDm.fromJson(json)).toList();


          print('✅ Request successful. Message: ${requestResponse}');

          return right(requestResponse);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: response.data.toString()));
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
  Future<Either<Failure, String?>> addFavourite(String userId, num productId) async{

    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.addFavorite}";
        print('🌐 Full URL: $fullUrl');



        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint:EndPoints.addFavorite,
          queryParameters: {'userId': userId,
           'productId': productId
          },
          options: Options(validateStatus: (_) => true),

        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final  myResponse = response.data;


          print('✅ Request successful. Message: ${myResponse}');

          return right(myResponse);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: response.data.toString()));
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
  Future<Either<Failure, String?>> removeFavourite(String userId, num productId)async {

    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.removeFavorite}";
        print('🌐 Full URL: $fullUrl');



        var response = await apiManager.deleteData(
          url: ApiConstant.baseUrl,
          endPoint:EndPoints.removeFavorite,
          queryParameters: {'userId': userId,
            'productId': productId
          },
          options: Options(validateStatus: (_) => true),

        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final  myResponse = response.data;

          print('✅ Request successful. Message: ${myResponse}');

          return right(myResponse);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: response.data.toString()));
        }
      } else {
        print('❌ No internet connection!');
        return left(NetworkError(errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e, stackTrace) {
      print('🛑 Exception caught: $e');
      print('📚 Stack trace:\n$stackTrace');
      return left(ServerError(errorMessage: e.toString()));
    }  }
}

