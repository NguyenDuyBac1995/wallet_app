import 'dart:convert';

import 'package:big_wallet/core/repository/base.response.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:dio/dio.dart';

enum RequestType { get, post, delete, put }

class Repository {
  final Dio _dio = Dio();
  Options? _options;
  Future<dynamic> requestAsync(String path, RequestType type,
      {dynamic data}) async {
    late Response<dynamic> response;
    final uri = Uri(scheme: Api.scheme, host: Api.baseUrl, path: path);
    final url = Uri.decodeFull(uri.toString());
    try {
      switch (type) {
        case RequestType.post:
          response = await _dio.post(url, data: data, options: _options);
          break;
        case RequestType.get:
          response = await _dio.get(url,
              options: _options, queryParameters: data ?? {});
          break;
        case RequestType.delete:
          response = await _dio.delete(url, data: data, options: _options);
          break;
        case RequestType.put:
          response = await _dio.put(url, data: data, options: _options);
          break;
      }
    } on DioError catch (e) {
      response.data =
          ApiResponse(message: e.message, type: "Exception", statusCode: 500);
    }
    try {
      return json.decode(response.data?.payload);
    } catch (exception) {
      return exception;
    }
  }
}
