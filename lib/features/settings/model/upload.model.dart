class UploadFile {
  String? id;
  String? absoluteUri;
  String? relativeUri;
  String? absolutePath;
  String? relativePath;
  String? fileName;
  String? originalFileName;
  int? contentLength;
  String? thumbnailName;
  String? thumbnailAbsoluteUri;
  Null? thumbnailRelativeUri;
  String? thumbnailPath;
  String? mime;

  UploadFile(
      {this.id,
      this.absoluteUri,
      this.relativeUri,
      this.absolutePath,
      this.relativePath,
      this.fileName,
      this.originalFileName,
      this.contentLength,
      this.thumbnailName,
      this.thumbnailAbsoluteUri,
      this.thumbnailRelativeUri,
      this.thumbnailPath,
      this.mime});

  UploadFile.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    absoluteUri = json['AbsoluteUri'];
    relativeUri = json['RelativeUri'];
    absolutePath = json['AbsolutePath'];
    relativePath = json['RelativePath'];
    fileName = json['FileName'];
    originalFileName = json['OriginalFileName'];
    contentLength = json['ContentLength'];
    thumbnailName = json['ThumbnailName'];
    thumbnailAbsoluteUri = json['ThumbnailAbsoluteUri'];
    thumbnailRelativeUri = json['ThumbnailRelativeUri'];
    thumbnailPath = json['ThumbnailPath'];
    mime = json['Mime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = this.id;
    data['AbsoluteUri'] = this.absoluteUri;
    data['RelativeUri'] = this.relativeUri;
    data['AbsolutePath'] = this.absolutePath;
    data['RelativePath'] = this.relativePath;
    data['FileName'] = this.fileName;
    data['OriginalFileName'] = this.originalFileName;
    data['ContentLength'] = this.contentLength;
    data['ThumbnailName'] = this.thumbnailName;
    data['ThumbnailAbsoluteUri'] = this.thumbnailAbsoluteUri;
    data['ThumbnailRelativeUri'] = this.thumbnailRelativeUri;
    data['ThumbnailPath'] = this.thumbnailPath;
    data['Mime'] = this.mime;
    return data;
  }
}
