
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/end_points.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/home_get_all_products_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/all_products_dm.dart';

@Injectable(as: HomeGetAllProductsRemoteDataSource)
 class HomeGetAllProductsRemoteDataSourceImpl implements HomeGetAllProductsRemoteDataSource {

  ApiManager apiManager;

  HomeGetAllProductsRemoteDataSourceImpl(this.apiManager);

  Future <Either<Failure,List<AllProductsDm>>>getHomeAllProducts () async{

    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: EndPoints.getHomeAllProducts,

          options: Options(validateStatus: (_) => true),

        );

        if (kDebugMode) {
          print(response.data);
        }
        final List<dynamic> myResponse = response.data;


        final requestResponse = myResponse
            .map((json) => AllProductsDm.fromJson(json))
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
  }

