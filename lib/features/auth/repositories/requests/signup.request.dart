class SignUpRequest {
  String? displayName;
  String? user;
  String? password;
  String? accessSystem;
  String? firebaseUid;
  List<dynamic>? configurations;

  SignUpRequest(
      {this.displayName,
      this.user,
      this.accessSystem,
      this.password,
      this.configurations,
      this.firebaseUid});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['User'] = user;
    data['Password'] = password;
    data['DisplayName'] = displayName;
    data['FirebaseUid'] = firebaseUid;
    data['AccessSystem'] = accessSystem;
    data['Configurations'] = configurations;
    return data;
  }
}

class ConfigurationsModel {
  final String context;
  final String key;
  final String value;

  ConfigurationsModel(
      {this.context = 'General', this.key = 'Currency', required this.value});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataConfigurations = <String, dynamic>{};
    dataConfigurations['Context'] = context;
    dataConfigurations['Key'] = key;
    dataConfigurations['value'] = value;

    return dataConfigurations;
  }
}
