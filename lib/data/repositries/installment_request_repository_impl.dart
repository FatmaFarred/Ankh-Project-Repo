import 'dart:convert';
import 'package:ankh_project/data/models/installment_request_model.dart';
import 'package:ankh_project/domain/entities/installment_request_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/installment_request_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../api_service/failure/error_handling.dart';

@LazySingleton(as: InstallmentRequestRepository)
class InstallmentRequestRepositoryImpl implements InstallmentRequestRepository {
  @override
  Future<Either<Failure, Unit>> sendInstallmentRequest(InstallmentRequestEntity request) async {
    final url = Uri.parse("https://ankhapi.runasp.net/api/RequestInspections/InstallmentRequest");

    final model = InstallmentRequestModel(
      marketerId: request.marketerId,
      productId: request.productId,
      clientName: request.clientName,
      clientPhone: request.clientPhone,
      installmentPeriod: request.installmentPeriod,
      downPayment: request.downPayment,
    );

    try {
      final jsonBody = model.toJson();
      print('Debug - API Request URL: $url');
      print('Debug - API Request Body: ${jsonEncode(jsonBody)}');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonBody),
      );

      print('Debug - API Response Status: ${response.statusCode}');
      print('Debug - API Response Body: ${response.body}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(unit);
      } else {
        return Left(Failure(errorMessage: "Failed to submit installment request: ${response.body}"));
      }
    } catch (e) {
      print('Debug - API Request Error: ${e.toString()}');
      return Left(Failure(errorMessage: "Error: ${e.toString()}"));
    }
  }
}
