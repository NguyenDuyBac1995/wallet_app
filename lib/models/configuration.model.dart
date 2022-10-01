class Configuration {
  String? context;
  String? key;
  String? value;
  String? description;
  String? id;
  DateTime? createdTime;
  String? createdBy;
  DateTime? modifiedTime;
  String? modifiedBy;
  bool? isDeleted;
  String? deletedBy;
  DateTime? deletedTime;

  Configuration(
      {this.context,
      this.key,
      this.value,
      this.description,
      this.id,
      this.createdTime,
      this.createdBy,
      this.modifiedTime,
      this.modifiedBy,
      this.isDeleted,
      this.deletedBy,
      this.deletedTime});

  Configuration.fromJson(Map<String, dynamic> json) {
    context = json['Context'];
    key = json['Key'];
    value = json['Value'];
    description = json['Description'];
    id = json['Id'];
    createdTime = DateTime.tryParse(json['CreatedTime']);
    createdBy = json['CreatedBy'];
    modifiedTime = DateTime.tryParse(json['ModifiedTime']);
    modifiedBy = json['ModifiedBy'];
    isDeleted = json['IsDeleted'];
    deletedBy = json['DeletedBy'];
    deletedTime = DateTime.tryParse(json['DeletedTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Context'] = context;
    data['Key'] = key;
    data['Value'] = value;
    data['Description'] = description;
    data['Id'] = id;
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
