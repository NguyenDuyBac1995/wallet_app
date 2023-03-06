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
  String? newPassword;
  String? token;

  ResetPasswordRequest({this.newPassword, this.token});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['NewPassword'] = newPassword;
    return data;
  }
}
