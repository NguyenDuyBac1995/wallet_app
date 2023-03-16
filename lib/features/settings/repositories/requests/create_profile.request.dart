class CreateProfilesRequest {
  String? displayName;
  String? phoneNumber;
  String? birthday;
  List<Configurations>? configurations;

  CreateProfilesRequest(
      {this.displayName, this.phoneNumber, this.birthday, this.configurations});

  CreateProfilesRequest.fromJson(Map<String, dynamic> json) {
    displayName = json['DisplayName'];
    phoneNumber = json['PhoneNumber'];
    birthday = json['Birthday'];
    if (json['Configurations'] != null) {
      configurations = <Configurations>[];
      json['Configurations'].forEach((v) {
        configurations!.add(Configurations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['DisplayName'] = displayName;
    data['PhoneNumber'] = phoneNumber;
    data['Birthday'] = birthday;
    if (configurations != null) {
      data['Configurations'] = configurations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Configurations {
  String? context;
  String? key;
  String? value;

  Configurations({this.context, this.key, this.value});

  Configurations.fromJson(Map<String, dynamic> json) {
    context = json['Context'];
    key = json['Key'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Context'] = context;
    data['Key'] = key;
    data['Value'] = value;
    return data;
  }
}
