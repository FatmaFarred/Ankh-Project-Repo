import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/data/models/product_details_dm.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_details_remote_data_Source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../api_service/api_constants.dart';
import '../../api_service/end_points.dart';
import '../../api_service/failure/error_handling.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../l10n/global_localization_helper.dart';
@Injectable(as: ProductDetailsRemoteDataSource)
class ProductDetailsRemoteDataSourceImpl implements ProductDetailsRemoteDataSource{
  ApiManager apiManager;
  ProductDetailsRemoteDataSourceImpl(this.apiManager);


  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(num productId) async{
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          url: ApiConstant.baseUrl,
          endPoint: "${EndPoints.getProductDetailsById}/$productId",

          options: Options(validateStatus: (_) => true),

        );


        if (kDebugMode) {
          print( " the response data ${response.data}");
        }
        print('Status code: ${response.statusCode}');
        print('Headers: ${response.headers}');
        print('Raw response: ${response.data}');
        print('Type: ${response.data.runtimeType}');
        final  myResponse = response.data;

         var requestResponse = ProductDetailsDm.fromJson(myResponse);


        if (response.statusCode! >= 200 && response.statusCode! < 300) {
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

