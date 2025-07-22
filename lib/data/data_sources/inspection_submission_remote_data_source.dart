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

    final request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields['RequestInspectionId'] = model.requestInspectionId.toString();
    request.fields['Status'] = model.status;
    request.fields['InspectorComment'] = model.inspectorComment;

    // Add image files (if any)
    if (model.images != null && model.images!.isNotEmpty) {
      for (var imagePath in model.images!) {
        request.files.add(await http.MultipartFile.fromPath('Images', imagePath));
      }
    }

    // Send the multipart request
    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to submit inspection report. ${response.body}');
    }
  }
}
