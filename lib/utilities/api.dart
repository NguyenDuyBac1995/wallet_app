class Api {
  static const scheme = 'http';
  static const baseUrl = 'dev-api.starauto.com.vn';
  static const configurationBaseUrl = 'msa-configuration';
  static const getConfigurations =
      '$configurationBaseUrl/odata/Configurations?\$count=true';
}
