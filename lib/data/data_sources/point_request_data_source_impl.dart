import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/domain/entities/all_point_price_entity.dart';
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
import '../../l10n/global_localization_helper.dart';
import '../models/all_point_price_dm.dart';
import '../models/balance_response_dm.dart';
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
        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }
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



        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
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

        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

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

  @override
  Future<Either<Failure, String?>> editPointPrice(String roleName, num price) async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}${EndPoints.editPointPrice}/$roleName";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');

       print ('📤 $price');
        var response = await apiManager.putData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.editPointPrice}/$roleName",
          options: Options(validateStatus: (_) => true),
          data: {
            "newPrice": price
          }

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
  Future<Either<Failure, List<AllPointPriceDm>>> getAllPointPrice()async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.getAllPointPrices}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');


        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.getAllPointPrices,
          options: Options(validateStatus: (_) => true),


        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');

        final myResponse = response.data;

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<dynamic> myResponse = response.data;


          final requestResponse = myResponse
              .map((json) => AllPointPriceDm.fromJson(json))
              .toList();
          print('✅ Request successful. Message: ${requestResponse}');
          return right(requestResponse);
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
  Future<Either<Failure, String?>> addPointRequest(String token, String description, num? points, num? commission) async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via  [32m${connectivityResult.join(", ")} [0m');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.addPointRequest}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending POST request with headers:');

        // Build the request data according to which value is present
        final Map<String, dynamic> data = {
          'description': description,
        };
        if (points != null) {
          data['points'] = points;
        } else if (commission != null) {
          data['amount'] = commission;
        }

        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.addPointRequest,
          options: Options(validateStatus: (_) => true),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          data: data,
        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');

        final myResponse = response.data;
        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          print('✅ Request successful. Message: ${myResponse['message']}');
          return right(myResponse['message']);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: myResponse));
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
  Future<Either<Failure, BalanceResponseDm>> getBalance(String token)async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.getBalance}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');


        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.getBalance,
          options: Options(validateStatus: (_) => true),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }

        );

        print('📥 Response received!');
        print('🔢 Status code: ${response.statusCode}');
        print('📦 Headers: ${response.headers}');
        print('📨 Raw body: ${response.data}');
        print('🔍 Response type: ${response.data.runtimeType}');

        final myResponse = response.data;
        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

        if (response.statusCode! >= 200 && response.statusCode! < 300) {


          final requestResponse = BalanceResponseDm.fromJson(myResponse);

          print('✅ Request successful. Message: ${requestResponse}');
          return right(requestResponse);
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
  Future<Either<Failure, String?>> adjustUserPoints(String userId, num points, String reason)async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.adjustUserPoints}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');


        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.adjustUserPoints,
          options: Options(validateStatus: (_) => true),

          data:{
            "userId": userId,
            "points": points,
            "reason": reason
          }



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
          return left(ServerError(errorMessage: myResponse));
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
  Future<Either<Failure, String?>> adjustCommissionForRoles(String token, num commissionRate, String roleName)async {
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.adjustCommissionForRoles}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');


        var response = await apiManager.putData(
            url: ApiConstant.baseUrl,
            endPoint: EndPoints.adjustCommissionForRoles,
            options: Options(validateStatus: (_) => true),

            data:{
              "roleName": roleName,
              "commissionPercentage": commissionRate
            },
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
        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

        if (response.statusCode! >= 200 && response.statusCode! < 300) {


          print('✅ Request successful. Message: ${myResponse['message']}');
          return right(myResponse['message']);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: myResponse));
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
  Future<Either<Failure, String?>> adjustCommissionForTeamLeader(String token, num commissionRate) async{
    try {
      print('🔌 Checking internet connection...');
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        print('✅ Internet connected via ${connectivityResult.join(", ")}');

        final fullUrl = "${ApiConstant.baseUrl}/${EndPoints.adjustCommissionForTeamLeader}";
        print('🌐 Full URL: $fullUrl');

        print('📤 Sending GET request with headers:');


        var response = await apiManager.putData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.adjustCommissionForTeamLeader,
          options: Options(validateStatus: (_) => true),

          data:{
            "roleName": "LeaderMarketer",
            "teamLeaderCommissionPercentage": commissionRate
          },
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
        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

        if (response.statusCode! >= 200 && response.statusCode! < 300) {


          print('✅ Request successful. Message: ${myResponse['message']}');
          return right(myResponse['message']);
        } else {
          print('⚠️ Request failed with status ${response.statusCode}');
          return left(ServerError(errorMessage: myResponse));
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

