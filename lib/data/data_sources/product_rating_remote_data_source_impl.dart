import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/api_service/end_points.dart';
import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_rating_remote_data_source.dart';
import 'package:ankh_project/l10n/global_localization_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRatingRemoteDataSource)
class ProductRatingRemoteDataSourceImpl implements ProductRatingRemoteDataSource {
  final ApiManager apiManager;

  ProductRatingRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failure, String>> addProductRating({
    required num productId,
    required String userId,
    required num stars,
    required String comment,
    required String token,
  }) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        if (kDebugMode) {
          print('📤 Sending POST request to: ${ApiConstant.baseUrl}Home/product-rating');
          print('📦 Headers: ${{"Authorization": "Bearer $token"}}');
          print('📨 Payload: ${{
            "dto": {
              "productId": productId,
              "userId": userId,
              "stars": stars.toInt(),
              "comment": comment,
            }
          }}');
        }

        var response = await apiManager.postData(
          url: ApiConstant.baseUrl,
          endPoint: "Home/product-rating",
          data: {
              "productId": productId,
              "userId": userId,
              "stars": stars.toInt(),
              "comment": comment,
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
        }

        if (response.statusCode == 401 || response.statusCode == 403) {
          return left(ServerError(errorMessage: "Session expired. Please log in again."));
        }

        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return right("Rating added successfully");
        } else {
          return left(ServerError(errorMessage: response.data['message'] ?? "Failed to add rating"));
        }
      } else {
        return left(NetworkError(errorMessage: GlobalLocalization.noInternet));
      }
    } catch (e) {
      return left(ServerError(errorMessage: e.toString()));
    }
  }
}