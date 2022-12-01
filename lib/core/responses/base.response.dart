class ApiResponse {
  int? statusCode;
  String? message;
  String? type;
  late bool isSuccess = statusCode == 201 || statusCode == 200 ? true : false;

  ApiResponse({this.statusCode, this.message, this.type});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    message = json['Message'];
    type = json['Type'];
  }
}
