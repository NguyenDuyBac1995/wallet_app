class ApiResponse {
  int? statusCode;
  int? totalCount;
  dynamic payload;
  String? message;
  String? type;

  ApiResponse(
      {this.statusCode,
      this.totalCount,
      this.payload,
      this.message,
      this.type});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    totalCount = json['TotalCount'];
    payload = json['Payload'];
    message = json['Message'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StatusCode'] = statusCode;
    data['TotalCount'] = totalCount;
    if (payload != null) {
      data['Payload'] = payload!.toJson();
    }
    data['Message'] = message;
    data['Type'] = type;
    return data;
  }
}
