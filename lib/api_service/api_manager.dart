import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_constants.dart';

@singleton
class ApiManager {
  final dio = Dio();

  Future<Response> getData({required String endPoint,
    required String url,

    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, dynamic>? headers}) {
    return dio.get(
      url + endPoint,
      queryParameters: queryParameters,
      options: Options(validateStatus: (status) => true, headers: headers),
    );
  }

  Future<Response> postData({
    required String endPoint,
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    // Only set JSON content-type if not using FormData
    final defaultHeaders = headers ?? {};
    if (data is! FormData) {
      defaultHeaders.putIfAbsent('Content-Type', () => 'application/json');
    }

    return dio.post(
      url + endPoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        validateStatus: (status) => true,
        headers: defaultHeaders,
      ),
    );
  }

  Future<Response> putData({
    required String endPoint,
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    // Only set JSON content-type if not using FormData
    final defaultHeaders = headers ?? {};
    if (data is! FormData) {
      defaultHeaders.putIfAbsent('Content-Type', () => 'application/json');
    }

    return dio.put(
      url + endPoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        validateStatus: (status) => true,
        headers: defaultHeaders,
      ),
    );
  }


  Future<Response> patchData({required String endPoint,
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    Map<String, dynamic>? headers}) {
    return dio.patch(
      url + endPoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(validateStatus: (status) => true, headers: headers),
    );
  }

  Future<Response> deleteData({required String endPoint,
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Object? data,
    Map<String, dynamic>? headers}) {
    return dio.delete(
      url + endPoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(validateStatus: (status) => true, headers: headers),
    );
  }
}