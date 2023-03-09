class PrimaryModel {
  String? id;
  String? displayName;
  String? lastName;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? birthday;
  dynamic? avatar;
  String? cover;
  String? identification;
  List<Configurations>? configurations;
  // String? addresses;
  bool? isPrimary;
  String? userId;
  // dynamic? tenants;
  String? concurrencyTimestamp;
  String? createdTime;
  String? createdBy;
  String? modifiedTime;
  String? modifiedBy;
  bool? isDeleted;
  String? deletedBy;
  String? deletedTime;

  PrimaryModel({
    this.id,
    this.displayName,
    this.lastName,
    this.firstName,
    this.email,
    this.phoneNumber,
    this.birthday,
    this.avatar,
    this.cover,
    this.identification,
    this.configurations,
    // this.addresses,
    this.isPrimary,
    this.userId,
    // this.tenants,
    this.concurrencyTimestamp,
    this.createdTime,
    this.createdBy,
    this.modifiedTime,
    this.modifiedBy,
    this.isDeleted,
    this.deletedBy,
    this.deletedTime,
  });

  PrimaryModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    displayName = json['DisplayName'];
    lastName = json['LastName'];
    firstName = json['FirstName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    birthday = json['Birthday'];
    avatar = json['Avatar'];
    cover = json['Cover'];
    identification = json['Identification'];
    if (json['Configurations'] != null) {
      configurations = <Configurations>[];
      json['Configurations'].forEach((v) {
        configurations!.add(Configurations.fromJson(v));
      });
    }
    // addresses = json['Addresses'];
    isPrimary = json['IsPrimary'];
    userId = json['UserId'];
    // tenants = json['Tenants'];
    concurrencyTimestamp = json['ConcurrencyTimestamp'];
    createdTime = json['CreatedTime'];
    createdBy = json['CreatedBy'];
    modifiedTime = json['ModifiedTime'];
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    deletedBy = json['DeletedBy'];
    deletedTime = json['DeletedTime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['DisplayName'] = displayName;
    data['LastName'] = lastName;
    data['FirstName'] = firstName;
    data['Email'] = email;
    data['PhoneNumber'] = phoneNumber;
    data['Birthday'] = birthday;
    data['Avatar'] = avatar;
    data['Cover'] = cover;
    data['Identification'] = identification;
    if (configurations != null) {
      data['Configurations'] = configurations?.map((v) => v.toJson()).toList();
    }
    // data['Addresses'] = addresses;
    data['IsPrimary'] = isPrimary;
    data['UserId'] = userId;
    // data['Tenants'] = tenants;
    data['ConcurrencyTimestamp'] = concurrencyTimestamp;
    data['CreatedTime'] = createdTime;
    data['CreatedBy'] = createdBy;
    data['ModifiedTime'] = modifiedTime;
    data['ModifiedBy'] = modifiedBy;
    data['IsDeleted'] = isDeleted;
    data['DeletedBy'] = deletedBy;
    data['DeletedTime'] = deletedTime;
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
