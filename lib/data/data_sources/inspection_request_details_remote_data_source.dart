import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../models/inspection_request_details_model.dart';

abstract class InspectionRequestDetailsRemoteDataSource {
  Future<InspectionRequestDetailsModel> getRequestDetails({
    required String token,
    required int requestId,
  });
}

@LazySingleton(as: InspectionRequestDetailsRemoteDataSource)
class InspectionRequestDetailsRemoteDataSourceImpl
    implements InspectionRequestDetailsRemoteDataSource {
  final http.Client client;

  InspectionRequestDetailsRemoteDataSourceImpl(this.client);

  @override
  Future<InspectionRequestDetailsModel> getRequestDetails({
    required String token,
    required int requestId,
  }) async {
    final url = Uri.parse(
        'https://ankhapi.runasp.net/api/Inspections/request-details/$requestId');

    final response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return InspectionRequestDetailsModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to load inspection request details');
    }
  }
}
