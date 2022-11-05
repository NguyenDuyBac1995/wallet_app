class SignUp {
  bool? verificationRequired;
  String? token;

  SignUp({this.verificationRequired, this.token});

  SignUp.fromJson(Map<String, dynamic> json) {
    verificationRequired = json['VerificationRequired'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VerificationRequired'] = verificationRequired;
    data['Token'] = token;
    return data;
  }
}
