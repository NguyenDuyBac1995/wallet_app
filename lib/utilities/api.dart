class Api {
  static const scheme = 'https';
  static const baseUrl = 'dev-api.megiservices.com';
  static const configurationBaseUrl = 'msa-configuration';
  static const identityBaseUrl = 'msa-identity';
  static const getConfigurations =
      '$configurationBaseUrl/odata/Configurations?\$count=true';
  static const signup = '$identityBaseUrl/odata/signup';
}
