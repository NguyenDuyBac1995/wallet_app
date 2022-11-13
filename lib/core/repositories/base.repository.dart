import 'package:big_wallet/core/responses/collection.response.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum RequestType { get, post, delete, put }

class Repository {
  final Dio _dio = Dio();
  Options? _options;
  Future<T?> requestAsync<T>(
      BuildContext context, String path, RequestType type,
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
      Toast.show(context, '${context.l10n?.couldNotConnect}',
          duration: const Duration(seconds: 5));
      if (e.response!.data is Map<String, dynamic>) {
        if (T == CollectionResponse) {
          return CollectionResponse.fromJson(e.response!.data) as T;
        } else {
          return SingleResponse.fromJson(e.response!.data) as T;
        }
      } else {
        if (T == CollectionResponse) {
          return CollectionResponse(
              message: e.message, statusCode: e.response!.statusCode) as T;
        } else {
          return SingleResponse(
              message: e.message, statusCode: e.response!.statusCode) as T;
        }
      }
    }
    return fromJson<T>(response.data);
  }

  T fromJson<T>(Map<String, dynamic> json) {
    if (T == CollectionResponse) {
      return CollectionResponse.fromJson(json) as T;
    } else {
      return SingleResponse.fromJson(json) as T;
    }
  }
}
