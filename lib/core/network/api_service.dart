import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:driver_application/core/utils/service_locator.dart';
import 'package:driver_application/features/Auth/data/data_sources/auth_local_data_source.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final Dio _dio;

  final String baseUrl = "https://127.0.0.1:8443/api/";

  ApiService(this._dio) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final loginData = getIt.get<AuthLocalDataSource>().getLoginData();
          if (loginData != null) {
            options.headers['Authorization'] =
                'Bearer ${loginData.data.accessToken}';
          }
          return handler.next(options);
        },
      ),
    );

    // Add interceptors here if needed (e.g. for Auth tokens, logging)
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          log(object.toString());
        },
      ),
    );

    configureDio(_dio);
  }
  void configureDio(Dio dio) {
    if (kDebugMode) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
  }

  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.get(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      ),
    );
  }

  Future<Response> post({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      ),
    );
  }

  Future<Response> patch({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.patch(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      ),
    );
  }

  Future<Response> put({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.put(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      ),
    );
  }

  Future<Response> delete({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    return await _dio.delete(
      endPoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      ),
    );
  }
}
