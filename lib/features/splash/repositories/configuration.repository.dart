import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/collection.response.dart';
import 'package:big_wallet/enums/context.enum.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:big_wallet/utilities/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class ConfigurationRepository extends Repository {
  Future<List<Configuration>> getConfigurationsAsync(
      BuildContext context) async {
    const url = Api.getConfigurations;
    final apiResponse = await requestAsync<CollectionResponse>(
        Context.general, context, url, RequestType.get);
    final result = <Configuration>[];
    Logger().d('apiResponse:$apiResponse');
    apiResponse.payload?.forEach((element) {
      result.add(Configuration.fromJson(element));
    });
    return result;
  }
}
