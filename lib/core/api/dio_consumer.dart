import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ebutler_task/core/api/api_consumer.dart';
import 'package:ebutler_task/core/api/app_interceptors.dart';
import 'package:ebutler_task/core/api/end_points.dart';
import 'package:ebutler_task/core/app/injection_container.dart' as di;
import 'package:ebutler_task/core/error/error_handler.dart';
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < ResponseCode.INTERNAL_SERVER_ERROR;
      };
    client.interceptors.add(di.instance<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(di.instance<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      throw ErrorHandler.handle(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameters,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      throw ErrorHandler.handle(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      throw ErrorHandler.handle(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }
}
