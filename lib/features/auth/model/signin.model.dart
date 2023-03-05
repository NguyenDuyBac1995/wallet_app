class SignInModel {
  String? id;
  String? userName;
  String? email;
  String? phoneNumber;
  String? accessToken;
  String? refreshToken;
  String? accessTokenExpired;
  String? refreshTokenExpired;

  SignInModel({
    this.id,
    this.userName,
    this.email,
    this.phoneNumber,
    this.accessToken,
    this.refreshToken,
    this.accessTokenExpired,
    this.refreshTokenExpired,
  });

  SignInModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['UserName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    accessToken = json['AccessToken'];
    refreshToken = json['RefreshToken'];
    accessTokenExpired = json['AccessTokenExpired'];
    refreshTokenExpired = json['RefreshTokenExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UserName'] = userName;
    data['Email'] = email;
    data['PhoneNumber'] = phoneNumber;
    data['AccessToken'] = accessToken;
    data['AccessTokenExpired'] = refreshToken;
    data['RefreshToken'] = accessTokenExpired;
    data['RefreshTokenExpired'] = refreshTokenExpired;
    return data;
  }
}
