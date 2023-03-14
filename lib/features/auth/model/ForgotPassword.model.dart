class ForgotPassword {
  String? token;

  ForgotPassword({this.token});

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    return data;
  }
}

class ResetPasswordModal {
  String? token;
  String? newPassword;

  ResetPasswordModal({this.token, this.newPassword});

  ResetPasswordModal.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    newPassword = json['NewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['NewPassword'] = newPassword;
    return data;
  }
}

class ChangePasswordModal {
  String? currentPassword;
  String? newPassword;

  ChangePasswordModal({this.currentPassword, this.newPassword});

  ChangePasswordModal.fromJson(Map<String, dynamic> json) {
    currentPassword = json['CurrentPassword'];
    newPassword = json['NewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CurrentPassword'] = currentPassword;
    data['NewPassword'] = newPassword;
    return data;
  }
}
