import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/core/responses/collection.response.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:big_wallet/utilities/api.dart';

class ConfigurationRepository extends Repository {
  Future<List<Configuration>?> getConfigurationsAsync() async {
    final url = Api.getConfigurations;
    final apiResponse =
        await requestAsync<CollectionResponse>(url, RequestType.get);
    final result = <Configuration>[];
    apiResponse.payload?.forEach((element) {
      result.add(Configuration.fromJson(element));
    });
    return result;
  }
}
