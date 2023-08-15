class ResponseCategoriesIcon {
  String? uri;
  String? name;
  String? description;
  List<String>? tags;

  ResponseCategoriesIcon({this.uri, this.name, this.description, this.tags});

  ResponseCategoriesIcon.fromJson(Map<String, dynamic> json) {
    uri = json['Uri'];
    name = json['Name'];
    description = json['Description'];
    tags = json['Tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Uri'] = uri;
    data['Name'] = name;
    data['Description'] = description;
    data['Tags'] = tags;
    return data;
  }
}

class ResponseCategories {
  String? id;
  String? name;
  String? description;
  String? icon;
  String? profileId;
  String? parentId;

  ResponseCategories(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.profileId,
      this.parentId});

  ResponseCategories.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    icon = json['Icon'];
    profileId = json['ProfileId'];
    parentId = json['ParentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Description'] = description;
    data['Icon'] = icon;
    data['ProfileId'] = profileId;
    data['ParentId'] = parentId;
    return data;
  }
}

class RequestCategories {
  String? name;
  String? icon;
  String? description;
  String? parentId;

  RequestCategories({this.name, this.icon, this.description, this.parentId});

  RequestCategories.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    icon = json['Icon'];
    description = json['Description'];
    parentId = json['ParentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Icon'] = icon;
    data['Description'] = description;
    data['ParentId'] = parentId;
    return data;
  }
}

class RequestPutCategories {
  String? id;
  RequestCategories? requestCategories;

  RequestPutCategories({this.id, this.requestCategories});

  RequestPutCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestCategories =
        json['data'] != null ? RequestCategories.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (requestCategories != null) {
      data['data'] = requestCategories!.toJson();
    }
    return data;
  }
}
