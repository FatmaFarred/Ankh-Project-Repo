import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'installment_pending_remote_data_source.dart';
import '../models/installment_pending_model.dart';

@LazySingleton(as: InstallmentPendingRemoteDataSource)
class InstallmentPendingRemoteDataSourceImpl
    implements InstallmentPendingRemoteDataSource {
  static const String _url =
      'https://ankhapi.runasp.net/api/RequestInspections/installments-pending';

  @override
  Future<List<InstallmentPendingModel>> getPendingInstallmentRequests() async {
    final response = await http
        .get(Uri.parse(_url))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => InstallmentPendingModel.fromJson(json))
          .toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception('API Error: ${error['message'] ?? 'Unknown error'}');
    }
  }
}
