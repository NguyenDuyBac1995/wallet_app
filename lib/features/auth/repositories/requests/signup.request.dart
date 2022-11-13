class SignUpRequest {
  String? displayName;
  String? user;
  String? password;

  SignUpRequest({this.displayName, this.user, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DisplayName'] = displayName;
    data['User'] = user;
    data['Password'] = password;
    return data;
  }
}
