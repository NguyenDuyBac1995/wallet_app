class RevokeTokenRequest {
  String? refreshToken;

  RevokeTokenRequest({this.refreshToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class RefreshTokenRequest {
  String? refreshToken;
  String? accessSystem;

  RefreshTokenRequest({this.accessSystem = 'megiservices', this.refreshToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    data['accessSystem'] = accessSystem;
    return data;
  }
}

class ForgotPasswordRequest {
  String? user;

  ForgotPasswordRequest({this.user});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['User'] = user;
    return data;
  }
}

class ResetPasswordRequest {
  String? token;
  String? newPassword;

  ResetPasswordRequest({this.token, this.newPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['NewPassword'] = newPassword;
    return data;
  }
}
