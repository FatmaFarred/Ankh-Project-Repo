import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../api_service/api_constants.dart';
import '../../api_service/api_manager.dart';
import '../../api_service/failure/error_handling.dart';
import '../../domain/entities/all_inpection_entity.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspections_remote_data_source.dart';
import '../../l10n/global_localization_helper.dart';
import '../models/all_inpection_dm.dart';
@Injectable(as: MyInspectionsRemoteDataSource)
class MyInspectionsRemoteDataSourceImpl implements MyInspectionsRemoteDataSource {
   ApiManager apiManager;

  MyInspectionsRemoteDataSourceImpl(this.apiManager);

  @override
  Future<Either<Failure, List<AllInpectionDm>>> getMyInspections({
    required String token,
    required String filter,
  }) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();
      String endpoint;

      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
      if (filter == 'today') {
        endpoint = 'Inspections/today';
      } else if (filter == 'tomorrow') {
        endpoint = 'Inspections/tomorrow';
      } else {
        endpoint = 'Inspections/by-status-name?status=$filter';
      }
      final response = await apiManager.getData(
        endPoint: endpoint,
        url: ApiConstant.baseUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        options: Options(validateStatus: (_) => true),

      );
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
}