class Api {
  static const scheme = 'https';
  static const baseUrl = 'dev-api.megiservices.com';
  static const configurationBaseUrl = 'msa-configuration';
  static const getConfigurations =
      '$configurationBaseUrl/odata/Configurations?\$count=true';
}
