import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/api_service/api_manager.dart';
import 'package:ankh_project/data/models/all_products_dm.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/products_by_brand_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductsByBrandRemoteDataSource)
class ProductsByBrandRemoteDataSourceImpl implements ProductsByBrandRemoteDataSource {
  final ApiManager api;

  ProductsByBrandRemoteDataSourceImpl(this.api);

  @override
  Future<List<AllProductsDm>> getProductsByBrandId(int brandId) async {
    final response = await api.getData(
      endPoint: 'TopBrand/car-by-brand/$brandId',
      url: ApiConstant.baseUrl,
    );

    if (response.statusCode == 200) {
      final List data = response.data as List;
      return data.map((e) => AllProductsDm.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products by brand. Status code: ${response.statusCode}');
    }
  }
}