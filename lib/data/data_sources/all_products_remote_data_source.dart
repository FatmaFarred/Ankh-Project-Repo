import 'package:ankh_project/api_service/api_constants.dart';
import 'package:injectable/injectable.dart';
import '../../api_service/api_manager.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/all_products_remote_data_source.dart';
import '../models/all_products_dm.dart';
import 'all_products_remote_data_source.dart';

@LazySingleton(as: AllProductsRemoteDataSource)
class AllProductsRemoteDataSourceImpl implements AllProductsRemoteDataSource {
  final ApiManager api;

  AllProductsRemoteDataSourceImpl(this.api);

  @override
  Future<List<AllProductsDm>> getAllProducts() async {
    final response = await api.getData(
      endPoint: 'Product',
      url: ApiConstant.baseUrl,
    );

    if (response.statusCode == 200) {
      final List data = response.data as List;
      return data.map((e) => AllProductsDm.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products. Status code: ${response.statusCode}');
    }
  }
}
