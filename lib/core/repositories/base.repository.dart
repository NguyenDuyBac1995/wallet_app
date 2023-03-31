import 'package:big_wallet/core/repositories/config_services.dart';
import 'package:big_wallet/core/responses/collection.response.dart';
import 'package:big_wallet/core/responses/single.response.dart';
import 'package:big_wallet/enums/context.enum.dart';
import 'package:big_wallet/models/translate.model.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:big_wallet/utilities/auth_utils.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum RequestType { get, post, delete, put }

class Repository {
  final Dio _dio = Dio();
  Options? _options;

  Future _getToken({bool? useProfileId, bool? primaryId = false}) async {
    var _token = await AuthUtils.instance.getToken();
    if (useProfileId != null && useProfileId) {
      if (primaryId != null && primaryId) {
        _options = ConfigServices.getHeaders(token: _token);
      } else {
        _options = ConfigServices.getHeaders(token: _token);
      }
    } else {
      _options = ConfigServices.getHeaders(token: _token);
    }
  }

  Future<T> requestAsync<T>(
    Context context,
    BuildContext buildContext,
    String path,
    RequestType type, {
    dynamic data,
    bool? useToken = false,
  }) async {
    late Response<dynamic> response;
    final uri = Uri(scheme: Api.scheme, host: Api.baseUrl, path: path);
    final url = Uri.decodeFull(uri.toString());
    if (useToken != null && useToken) {
      await _getToken();
    } else {
      _options = ConfigServices.getHeaders();
    }

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
      if (e.response!.data is Map<String, dynamic>) {
        var singleResponse = SingleResponse.fromJson(e.response!.data);
        var translate = Translate.fromJson(singleResponse.payload);
        Toast.show(buildContext,
            '${buildContext.l10n?.get(context, translate, '${singleResponse.message}')}',
            duration: const Duration(seconds: 5));
        return singleResponse as T;
      } else {
        Toast.show(buildContext, '${buildContext.l10n?.couldNotConnect}',
            duration: const Duration(seconds: 5));
        return SingleResponse.fromJson(e.response!.data) as T;
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

class NetworkError extends Error {}
