import 'package:ankh_project/data/data_sources/remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/price_offer_request_model.dart';

@Injectable(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl(this.dio);

  @override
  Future<int> sendPriceOfferRequest(PriceOfferRequestModel request) async {
    final response = await dio.post(
      'https://ankhapi.runasp.net/api/RequestInspections/PriceOfferRequest',
      data: request.toJson(),
    );
    return response.statusCode ?? 500;
  }
}
