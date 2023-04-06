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
  static const getPrimary = "/msa-user-profile/odata/me/primary()";
  static const getExchangeRates =
      "/msa-finance/odata/ExchangeRates/Latest(source='USD',symbols=['VND','CNY'])";
  static const getProfiles =
      '/msa-user-profile/odata/me?\$count=true&\$orderby=CreatedTime asc';
  static const createProfiles = '/msa-user-profile/odata/me';
  static const editProfiles = '/msa-user-profile/odata/me(%id%)';
  static const getByIdProfile = '/msa-user-profile/odata/me(%id%)';
  static const postChangePassword = '/msa-identity/odata/me/changepassword';
  static const postUpLoadFile = '/msa-storage/odata/storage/upload';
  static const getCategoriesIcon =
      '/msa-finance/odata/categories/icons(search=\'%id%\')';
  static const getCategories = '/msa-finance/odata/categories?\$count=true';
  static const postCategories = '/msa-finance/odata/categories';
  static const getCategoriesId = '/msa-finance/odata/categories(%id%)';
  static const putCategories = '/msa-finance/odata/categories(%id%)';
  static const deleteCategories = '/msa-finance/odata/categories(%id%)';
  static const createWallets = '/msa-wallet/odata/me';
  static const getWallets = '/msa-wallet/odata/me?\$count=true';
  static const updateWallets = '/msa-wallet/odata/me(%id%)';
  static const getWalletsById = '/msa-wallet/odata/me(%id%)';
}
