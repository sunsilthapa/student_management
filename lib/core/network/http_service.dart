
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:student_management_hive_api/config/constants/api_endpoints.dart';
import 'package:student_management_hive_api/core/network/dio_error_intercepter.dart';

final httpServiceProvider = Provider.autoDispose<Dio>(
  (ref) => HttpService(Dio()).dio,
);

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }
}
