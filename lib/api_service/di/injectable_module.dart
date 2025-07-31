import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@module
abstract class InjectableModule {
  @lazySingleton
  http.Client get client => http.Client();
  Dio get dio => Dio();
}
