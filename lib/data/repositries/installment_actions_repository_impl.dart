import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../domain/entities/process_installment_request_entity.dart';
import '../../domain/repositries_and_data_sources/repositries/installment_actions_repository.dart';
import '../models/process_installment_request_model.dart';

@LazySingleton(as: InstallmentActionsRepository)
class InstallmentActionsRepositoryImpl implements InstallmentActionsRepository {
  @override
  Future<void> processInstallmentRequest({
    required int id,
    required ProcessInstallmentRequestEntity request,
  }) async {
    final url = Uri.parse('https://ankhapi.runasp.net/api/RequestInspections/installments/$id/process');

    final model = ProcessInstallmentRequestModel(
      status: request.status,
      adminNote: request.adminNote,
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to process installment request');
    }
  }
}
