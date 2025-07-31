import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';  // <-- import injectable

import '../../domain/entities/product_post_entity.dart';
import '../models/product_post_model.dart';

abstract class EditProductRemoteDataSource {
  Future<void> editProduct(int id, ProductPostEntity entity);
}

@LazySingleton(as: EditProductRemoteDataSource)  // <-- injectable annotation here
class EditProductRemoteDataSourceImpl implements EditProductRemoteDataSource {
  final Dio dio;

  EditProductRemoteDataSourceImpl(this.dio);

  @override
  Future<void> editProduct(int id, ProductPostEntity entity) async {
    final data = ProductPostModel.toFormData(entity);

    final response = await dio.put(
      'https://ankhapi.runasp.net/api/Product/$id',
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit product');
    }
  }
}
