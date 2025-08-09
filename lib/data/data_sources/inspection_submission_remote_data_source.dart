import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../api_service/failure/error_handling.dart';
import '../models/inspection_submission_model.dart';

abstract class InspectionSubmissionRemoteDataSource {
  Future <Either<Failure,String?>> submitReport(InspectionSubmissionModel model);
}

@LazySingleton(as: InspectionSubmissionRemoteDataSource)
class InspectionSubmissionRemoteDataSourceImpl
    implements InspectionSubmissionRemoteDataSource {
  final http.Client client;

  InspectionSubmissionRemoteDataSourceImpl(this.client);

  @override

  Future<Either<Failure, String?>> submitReport(InspectionSubmissionModel model) async {
    final url = Uri.parse('https://ankhapi.runasp.net/api/Inspections/submit-report'); // ✅ Fixed: Removed trailing spaces

    final request = http.MultipartRequest('POST', url);

    try {
      // Add required fields
      request.fields['RequestInspectionId'] = model.requestInspectionId.toString();
      request.fields['Status'] = model.status.toString();
      request.fields['InspectorComment'] = model.inspectorComment ?? '';

      // Add images if present
      if (model.images != null && model.images!.isNotEmpty) {
        for (var imagePath in model.images!) {
          print('   ➤ Adding image: $imagePath');
          request.files.add(await http.MultipartFile.fromPath('Images', imagePath));
        }
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('📡 Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ✅ Parse message from response
        try {

          return Right(response.body.toString());
        } on FormatException {
          return const Right('Report submitted successfully');
        }
      } else {
        // ❌ Handle server error
        final String errorMsg = _parseErrorMessage(response.body);
        return Left(Failure(errorMessage: errorMsg));
      }
    } catch (e) {
      return Left(Failure(errorMessage:'No internet connection. Please try again.'));
    }
  }

// Helper to extract meaningful error message
  String _parseErrorMessage(dynamic body) {
    try {
      if (body is String) {
        final Map<String, dynamic> jsonBody = json.decode(body);
        return jsonBody['error'] ??
            jsonBody['message'] ??
            jsonBody['Message'] ??
            'Failed to submit inspection report.';
      } else if (body is Map) {
        return body['error'] ?? body['message'] ?? body['Message'] ??
            'Submission failed.';
      }
      return 'Failed to submit inspection report.';
    } catch (e) {
      return 'Server error: Invalid response format.';
    }
  }}