class UploadModel {
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

  UploadModel(
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

  UploadModel.fromJson(Map<String, dynamic> json) {
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
