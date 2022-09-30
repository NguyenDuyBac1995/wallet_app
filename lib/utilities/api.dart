class Api {
  static String scheme = 'http';
  static String baseUrl = 'dev-api.starauto.com.vn';
  static String configurationBaseUrl = 'msa-configuration';
  static String getConfigurations =
      '$configurationBaseUrl/odata/Configurations?\$count=true';
}
