import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../models/inspection_submission_model.dart';

abstract class InspectionSubmissionRemoteDataSource {
  Future<void> submitReport(InspectionSubmissionModel model);
}

@LazySingleton(as: InspectionSubmissionRemoteDataSource)
class InspectionSubmissionRemoteDataSourceImpl
    implements InspectionSubmissionRemoteDataSource {
  final http.Client client;

  InspectionSubmissionRemoteDataSourceImpl(this.client);

  @override
  Future<void> submitReport(InspectionSubmissionModel model) async {
    final url = Uri.parse('https://ankhapi.runasp.net/api/Inspections/submit-report');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit inspection report');
    }
  }
}
