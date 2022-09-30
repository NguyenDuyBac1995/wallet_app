import 'dart:convert';

import 'package:big_wallet/core/repository/base.repository.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:big_wallet/utilities/api.dart';

class ConfigurationRepository extends Repository {
  Future<List<Configuration>?> getConfigurationsAsync() async {
    var url = Api.getConfigurations;
    final result = await requestAsync(url, RequestType.get);
    Iterable models = jsonDecode(result.body);
    List<Configuration> configurations = [];
    for (var model in models) {
      Configuration configuration = Configuration.fromJson(model);
      configurations.add(configuration);
    }
    return configurations;
  }
}
