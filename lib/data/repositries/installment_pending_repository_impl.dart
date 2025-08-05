import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:ankh_project/data/models/installment_pending_model.dart';
import 'package:ankh_project/domain/entities/installment_pending_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/installment_pending_repository.dart';

@LazySingleton(as: InstallmentPendingRepository)
class InstallmentPendingRepositoryImpl implements InstallmentPendingRepository {
  final http.Client _client;

  InstallmentPendingRepositoryImpl(this._client);

  static const String baseUrl = 'https://ankhapi.runasp.net/api/RequestInspections';

  @override
  Future<List<InstallmentPendingEntity>> getPendingInstallmentRequests() async {
    final response = await _client.get(Uri.parse('$baseUrl/installments-pending'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => InstallmentPendingModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pending installments');
    }
  }

  @override
  Future<void> updateInstallmentStatus({
    required int id,
    required int status,
    required String adminNote,
  }) async {
    final url = Uri.parse('$baseUrl/installments/$id/process');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'status': status,
        'adminNote': adminNote,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update installment status');
    }
  }
}
