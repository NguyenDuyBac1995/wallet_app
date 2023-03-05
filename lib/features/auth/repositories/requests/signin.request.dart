class SignInRequest {
  String? user;
  String? password;
  String? accessSystem;

  SignInRequest({this.accessSystem = 'big-wallet', this.password, this.user});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['password'] = password;
    data['accessSystem'] = accessSystem;
    return data;
  }
}
