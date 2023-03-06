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
