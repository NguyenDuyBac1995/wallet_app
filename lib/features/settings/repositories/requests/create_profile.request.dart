import 'package:big_wallet/features/auth/model/upload.model.dart';

class CreateProfilesRequest {
  String? displayName;
  String? phoneNumber;
  String? birthday;
  String? id;
  String? email;
  UploadModel? avatar;
  List<Configurations>? configurations;

  CreateProfilesRequest(
      {this.displayName,
      this.phoneNumber,
      this.birthday,
      this.configurations,
      this.email,
      this.avatar,
      this.id});

  CreateProfilesRequest.fromJson(Map<String, dynamic> json) {
    displayName = json['DisplayName'];
    phoneNumber = json['PhoneNumber'];
    birthday = json['Birthday'];
    id = json['id'];
    email = json['Email'];
    avatar = json['Avatar'];
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
    data['id'] = id;
    data['Email'] = email;
    if (configurations != null) {
      data['Configurations'] = configurations!.map((v) => v.toJson()).toList();
    }
    if (avatar != null) {
      data['Avatar'] = avatar;
    }
    return data;
  }
}

class Configurations {
  String? context;
  String? key;
  String? value;

  Configurations({this.context = 'General', this.key = 'Currency', this.value});

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
