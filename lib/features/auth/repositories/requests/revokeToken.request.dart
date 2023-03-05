class RevokeTokenRequest {
  String? refreshToken;
  String? accessSystem;

  RevokeTokenRequest({this.accessSystem = 'megiservices', this.refreshToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refreshToken'] = refreshToken;
    data['accessSystem'] = accessSystem;
    return data;
  }
}
