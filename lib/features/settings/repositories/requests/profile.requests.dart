class ProfileRequest {
  String? displayName;
  String? lastName;
  String? firstName;
  String? email;
  String? phoneNumber;
  String? birthday;
  Avatar? avatar;
  Avatar? cover;
  Identification? identification;
  List<Addresses>? addresses;
  bool? isPrimary;

  ProfileRequest(
      {this.displayName,
      this.lastName,
      this.firstName,
      this.email,
      this.phoneNumber,
      this.birthday,
      this.avatar,
      this.cover,
      this.identification,
      this.addresses,
      this.isPrimary});

  ProfileRequest.fromJson(Map<String, dynamic> json) {
    displayName = json['DisplayName'];
    lastName = json['LastName'];
    firstName = json['FirstName'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    birthday = json['Birthday'];
    avatar = json['Avatar'] != null ? Avatar.fromJson(json['Avatar']) : null;
    cover = json['Cover'] != null ? Avatar.fromJson(json['Cover']) : null;
    identification = json['Identification'] != null
        ? Identification.fromJson(json['Identification'])
        : null;
    if (json['Addresses'] != null) {
      addresses = <Addresses>[];
      json['Addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    isPrimary = json['IsPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DisplayName'] = displayName;
    data['LastName'] = lastName;
    data['FirstName'] = firstName;
    data['Email'] = email;
    data['PhoneNumber'] = phoneNumber;
    data['Birthday'] = birthday;
    if (this.avatar != null) {
      data['Avatar'] = avatar!.toJson();
    }
    if (cover != null) {
      data['Cover'] = cover!.toJson();
    }
    if (identification != null) {
      data['Identification'] = identification!.toJson();
    }
    if (addresses != null) {
      data['Addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['IsPrimary'] = isPrimary;
    return data;
  }
}

class Avatar {
  String? id;
  String? absoluteUri;
  String? relativeUri;
  String? absolutePath;
  String? relativePath;
  String? fileName;
  String? originalFileName;
  int? contentLength;
  String? thumbnailAbsoluteUri;
  String? thumbnailRelativeUri;
  String? thumbnailPath;
  String? mime;

  Avatar(
      {this.id,
      this.absoluteUri,
      this.relativeUri,
      this.absolutePath,
      this.relativePath,
      this.fileName,
      this.originalFileName,
      this.contentLength,
      this.thumbnailAbsoluteUri,
      this.thumbnailRelativeUri,
      this.thumbnailPath,
      this.mime});

  Avatar.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    absoluteUri = json['AbsoluteUri'];
    relativeUri = json['RelativeUri'];
    absolutePath = json['AbsolutePath'];
    relativePath = json['RelativePath'];
    fileName = json['FileName'];
    originalFileName = json['OriginalFileName'];
    contentLength = json['ContentLength'];
    thumbnailAbsoluteUri = json['ThumbnailAbsoluteUri'];
    thumbnailRelativeUri = json['ThumbnailRelativeUri'];
    thumbnailPath = json['ThumbnailPath'];
    mime = json['Mime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['AbsoluteUri'] = absoluteUri;
    data['RelativeUri'] = relativeUri;
    data['AbsolutePath'] = absolutePath;
    data['RelativePath'] = relativePath;
    data['FileName'] = fileName;
    data['OriginalFileName'] = originalFileName;
    data['ContentLength'] = contentLength;
    data['ThumbnailAbsoluteUri'] = thumbnailAbsoluteUri;
    data['ThumbnailRelativeUri'] = thumbnailRelativeUri;
    data['ThumbnailPath'] = thumbnailPath;
    data['Mime'] = mime;
    return data;
  }
}

class Identification {
  String? no;
  String? issuedDate;
  String? issuedBy;
  int? type;

  Identification({this.no, this.issuedDate, this.issuedBy, this.type});

  Identification.fromJson(Map<String, dynamic> json) {
    no = json['No'];
    issuedDate = json['IssuedDate'];
    issuedBy = json['IssuedBy'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['No'] = no;
    data['IssuedDate'] = issuedDate;
    data['IssuedBy'] = issuedBy;
    data['Type'] = type;
    return data;
  }
}

class Addresses {
  String? title;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  int? longitude;
  int? latitude;

  Addresses(
      {this.title,
      this.address,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.longitude,
      this.latitude});

  Addresses.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    address = json['Address'];
    city = json['City'];
    state = json['State'];
    postalCode = json['PostalCode'];
    country = json['Country'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Address'] = address;
    data['City'] = city;
    data['State'] = state;
    data['PostalCode'] = postalCode;
    data['Country'] = country;
    data['Longitude'] = longitude;
    data['Latitude'] = latitude;
    return data;
  }
}
