class Api {
  static const scheme = 'https';
  static const baseUrl = 'api.megiservices.com';
  static const configurationBaseUrl = 'msa-configuration';
  static const identityBaseUrl = 'msa-identity';
  static const getConfigurations =
      '$configurationBaseUrl/odata/Configurations?\$count=true';
  static const signup = '$identityBaseUrl/odata/auth/signup';
  static const baseURLink = "https://api.megiservices.com";

  static const postSignUp = "$identityBaseUrl/odata/auth/signup";
  static const postSignIn = "$identityBaseUrl/odata/auth/signin";
  static const postRevokeToken = "$identityBaseUrl/odata/auth/RevokeToken";
  static const postRefreshToken = "$identityBaseUrl/odata/auth/RefreshToken";
  static const postForgotPassword =
      "$identityBaseUrl/odata/auth/ForgotPassword";
  static const postResetPassword = "$identityBaseUrl/odata/auth/ResetPassword";
}
